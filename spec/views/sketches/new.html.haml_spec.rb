require 'spec_helper'

describe "sketches/new" do
  before(:each) do
    assign(:sketch, stub_model(Sketch,
      :topic_id => 1,
      :artist_id => 1,
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new sketch form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sketches_path, :method => "post" do
      assert_select "input#sketch_topic_id", :name => "sketch[topic_id]"
      assert_select "input#sketch_artist_id", :name => "sketch[artist_id]"
      assert_select "input#sketch_url", :name => "sketch[url]"
    end
  end
end
