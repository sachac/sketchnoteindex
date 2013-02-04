require 'spec_helper'

describe "topics/edit" do
  before(:each) do
    @topic = assign(:topic, stub_model(Topic,
      :name => "MyString",
      :people => "MyString",
      :collection_id => 1
    ))
  end

  it "renders the edit topic form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => topics_path(@topic), :method => "post" do
      assert_select "input#topic_name", :name => "topic[name]"
      assert_select "input#topic_people", :name => "topic[people]"
      assert_select "input#topic_collection_id", :name => "topic[collection_id]"
    end
  end
end
