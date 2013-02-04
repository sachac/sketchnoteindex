require 'spec_helper'

describe "sketches/show" do
  before(:each) do
    @sketch = assign(:sketch, stub_model(Sketch,
      :topic_id => 1,
      :artist_id => 2,
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Url/)
  end
end
