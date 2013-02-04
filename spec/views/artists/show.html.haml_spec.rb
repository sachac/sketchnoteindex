require 'spec_helper'

describe "artists/show" do
  before(:each) do
    @artist = assign(:artist, stub_model(Artist,
      :name => "Name",
      :image_url => "Image Url",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Image Url/)
    rendered.should match(/Url/)
  end
end
