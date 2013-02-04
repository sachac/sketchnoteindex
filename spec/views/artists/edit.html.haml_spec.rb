require 'spec_helper'

describe "artists/edit" do
  before(:each) do
    @artist = assign(:artist, stub_model(Artist,
      :name => "MyString",
      :image_url => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit artist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => artists_path(@artist), :method => "post" do
      assert_select "input#artist_name", :name => "artist[name]"
      assert_select "input#artist_image_url", :name => "artist[image_url]"
      assert_select "input#artist_url", :name => "artist[url]"
    end
  end
end
