require 'spec_helper'

describe Collection do
  it "can create a new collection by name" do
    Collection.get_or_create("Conference")
    Collection.count.should == 1
  end
  it "does not create duplicate collections by default" do
    x = Collection.get_or_create("Conference")
    y = Collection.get_or_create("Conference")
    Collection.count.should == 1
    x.should == y
  end
  it "returns the collection if specified" do
    c = FactoryGirl.create(:collection)
    Collection.get_or_create(c)
    Collection.count.should == 1
  end
  it "complains about ambiguity" do
    a = FactoryGirl.create(:collection, :name => "Conference")
    b = FactoryGirl.create(:collection, :name => "Conference")
    expect { Collection.get_or_create("Conference") }.to raise_error
  end
  # it "knows the number of overlaps" do
  #   t = FactoryGirl.create(:topic)
  #   t2 = FactoryGirl.create(:topic, collection: t.collection)
  #   a = FactoryGirl.create(:artist, name: 'John Smith')
  #   b = FactoryGirl.create(:artist, name: 'Jane Smith')
  #   s = Sketch.process(url: "http://example.com/png", artist: a, topic: t)
  #   s2 = Sketch.process(url: "http://example.com/png", artist: b, topic: t)
  #   t.collection.overlap_count.should == 1
  # end
  # it "knows the number of contributing artists" do
  #   t = FactoryGirl.create(:topic)
  #   t2 = FactoryGirl.create(:topic, collection: t.collection)
  #   a = FactoryGirl.create(:artist, name: 'John Smith')
  #   b = FactoryGirl.create(:artist, name: 'Jane Smith')
  #   s = Sketch.process(url: "http://example.com/png", artist: a, topic: t)
  #   s2 = Sketch.process(url: "http://example.com/png", artist: b, topic: t2)
  #   t.collection.artist_count.should == 2
  # end
  # it "can list the contributing artists" do
  #   t = FactoryGirl.create(:topic)
  #   t2 = FactoryGirl.create(:topic, collection: t.collection)
  #   a = FactoryGirl.create(:artist, name: 'John Smith')
  #   b = FactoryGirl.create(:artist, name: 'Jane Smith')
  #   s = Sketch.process(url: "http://example.com/png", artist: a, topic: t)
  #   s2 = Sketch.process(url: "http://example.com/png", artist: b, topic: t2)
  #   t.collection.artists.should_include a
  #   t.collection.artists.should_include b
  # end
end
