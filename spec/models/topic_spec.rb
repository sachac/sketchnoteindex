require 'spec_helper'

describe Topic do
  it "can create a new topic by name" do
    Topic.get_or_create("Conference topic")
    Topic.count.should == 1
  end
  it "does not create duplicate topic by default" do
    x = Topic.get_or_create("Conference topic")
    y = Topic.get_or_create("Conference topic")
    Topic.count.should == 1
    x.should == y
  end
  it "returns the topic if specified" do
    c = FactoryGirl.create(:topic)
    Topic.get_or_create(c)
    Topic.count.should == 1
  end
  it "complains about ambiguity" do
    a = FactoryGirl.create(:topic, name: "Conference topic")
    b = FactoryGirl.create(:topic, name: "Conference topic")
    expect { Topic.get_or_create("Conference topic") }.to raise_error
  end
  it "disambiguates by collection object" do
    a = FactoryGirl.create(:topic, name: "Conference topic")
    b = FactoryGirl.create(:topic, name: "Conference topic")
    Topic.get_or_create("Conference topic", a.collection).should == a
  end
  it "disambiguates by collection name" do
    a = FactoryGirl.create(:topic, name: "Conference topic")
    b = FactoryGirl.create(:topic, name: "Conference topic")
    Topic.get_or_create("Conference topic", a.collection.name).should == a
  end
  it "can merge duplicates"
  # it "knows the number of contributing artists" do
  #   t = FactoryGirl.create(:topic)
  #   s = Sketch.process(url: "http://example.com/png", artist: "John Smith", topic: t)
  #   s2 = Sketch.process(url: "http://example.com/png", artist: "Jane Smith", topic: t)
  #   t.artist_count.should == 2
  # end
  # it "can distinguish between contributing artists with the same name" do
  #   t = FactoryGirl.create(:topic)
  #   a = FactoryGirl.create(:artist, name: "John Smith")
  #   b = FactoryGirl.create(:artist, name: "John Smith")
  #   s = Sketch.process(url: "http://example.com/png", artist: a, topic: t)
  #   s2 = Sketch.process(url: "http://example.com/png", artist: b, topic: t)
  #   t.artist_count.should == 2
  # end
  # it "can deal with one person having multiple submissions" do
  #   t = FactoryGirl.create(:topic)
  #   a = FactoryGirl.create(:artist, name: "John Smith")
  #   b = FactoryGirl.create(:artist, name: "John Smith")
  #   s = Sketch.process(url: "http://example.com/png", artist: a, topic: t)
  #   s2 = Sketch.process(url: "http://example.com/png", artist: a, topic: t)
  #   t.artist_count.should == 1
  # end
end
