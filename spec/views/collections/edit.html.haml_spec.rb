require 'spec_helper'

describe "collections/edit" do
  before(:each) do
    @collection = assign(:collection, stub_model(Collection,
      :name => "MyString",
      :date_string => "MyString",
      :location => "MyString"
    ))
  end

  it "renders the edit collection form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => collections_path(@collection), :method => "post" do
      assert_select "input#collection_name", :name => "collection[name]"
      assert_select "input#collection_date_string", :name => "collection[date_string]"
      assert_select "input#collection_location", :name => "collection[location]"
    end
  end
end
