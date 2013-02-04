require 'spec_helper'

describe "collections/new" do
  before(:each) do
    assign(:collection, stub_model(Collection,
      :name => "MyString",
      :date_string => "MyString",
      :location => "MyString"
    ).as_new_record)
  end

  it "renders new collection form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => collections_path, :method => "post" do
      assert_select "input#collection_name", :name => "collection[name]"
      assert_select "input#collection_date_string", :name => "collection[date_string]"
      assert_select "input#collection_location", :name => "collection[location]"
    end
  end
end
