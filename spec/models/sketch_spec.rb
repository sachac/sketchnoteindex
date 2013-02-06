require 'spec_helper'

describe Sketch do
  it "is invalid without a URL" do
    FactoryGirl.build(:sketch, url: nil).should_not be_valid
  end
  it "knows how to set itself up given parameters" do
    Sketch.process(url: "http://example.com/png", artist: "John Smith", collection: "TED", topic: "Hello")
    Sketch.count.should == 1
    s = Sketch.first
    s.url.should == "http://example.com/png"
    s.artist.name.should == "John Smith"
    s.collection.name.should == "TED"
    s.topic.name.should == "Hello"
  end
  it "allows us to specify the topic in case two topics have the same name" do
    t1 = FactoryGirl.create(:topic, :name => "Hello")
    t2 = FactoryGirl.create(:topic, :name => "Hello")
    t3 = FactoryGirl.create(:topic, :name => "Hello")
    s = Sketch.process(url: "http://example.com/png", artist: "John Smith", topic: t2)
    Sketch.count.should == 1
    s.topic.should == t2
    s.topic.collection.should == t2.collection
  end
  it "can disambiguate topics based on the specified collection object" do
    c1 = FactoryGirl.create(:collection, :name => "Conference")
    t1 = FactoryGirl.create(:topic, :collection => c1, :name => "Hello")
    c2 = FactoryGirl.create(:collection, :name => "Conference")
    t2 = FactoryGirl.create(:topic, :collection => c2, :name => "Hello")
    s = Sketch.process(url: "http://example.com/png", artist: "John Smith", collection: c2, topic: "Hello")
    s.topic.should == t2
  end
  it "can disambiguate topics based on the specified collection name" do
    c1 = FactoryGirl.create(:collection, :name => "Conference")
    t1 = FactoryGirl.create(:topic, :collection => c1, :name => "Hello")
    c2 = FactoryGirl.create(:collection, :name => "Conference 2")
    t2 = FactoryGirl.create(:topic, :collection => c2, :name => "Hello")
    s = Sketch.process(url: "http://example.com/png", artist: "John Smith", collection: "Conference", topic: "Hello")
    s.topic.should == t1
  end
  it "should complain about ambiguity" do
    c1 = FactoryGirl.create(:collection, :name => "Conference")
    t1 = FactoryGirl.create(:topic, :collection => c1, :name => "Hello")
    c2 = FactoryGirl.create(:collection, :name => "Conference")
    t2 = FactoryGirl.create(:topic, :collection => c2, :name => "Hello")
    expect { Sketch.process(url: "http://example.com/png", artist: "John Smith", collection: "Conference", topic: "Hello") }.to raise_error
  end
  it "allows duplicate URLs for different information" do
    s = Sketch.process(url: "http://example.com/png", artist: "John Smith", collection: "Conference 1", topic: "Hello")
    s2 = Sketch.process(url: "http://example.com/png", artist: "John Smith", collection: "Conference 2", topic: "Hello")
    Sketch.count.should == 2
  end

  it "guesses information from a Flickr page" do
    # Create sample with the same title
    s1 = Sketch.process(url: "http://example.com/png", collection: "Interaction 2012 Dublin", topic: "Beyond Gamification")
    s2 = Sketch.process(url: "http://example.com/png", collection: "Interaction 2012 Dublin", topic: "Another Talk")
    data = IO.read(Rails.root.join("spec", "fixtures", "flickr-sample.html"))
    s = Sketch.parse_flickr(data, "Interaction 2012 Dublin")
    s.artist.name.should == "Jason Alderman"
    s.upload_date.year.should == 2012
    s.upload_date.month.should == 2
    s.upload_date.day.should == 24
#    s.topic.should == s1.topic
  end
end
