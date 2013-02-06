require 'spec_helper'

describe Artist do
  it "identifies artists by Flickr URL" do
    url = "http://www.flickr.com/photos/example1/5839049615/in/photostream"
    a1 = FactoryGirl.create(:artist, flickr_username: "example1")
    a2 = FactoryGirl.create(:artist, flickr_username: "example2")
    Artist.guess_by_url(url).should == a1
  end
end
