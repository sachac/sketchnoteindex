require 'spec_helper'

describe "topics/index" do
  before(:each) do
    assign(:topics, [
      stub_model(Topic,
        :name => "Name",
        :people => "People",
        :collection_id => 1
      ),
      stub_model(Topic,
        :name => "Name",
        :people => "People",
        :collection_id => 1
      )
    ])
  end

  it "renders a list of topics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "People".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
