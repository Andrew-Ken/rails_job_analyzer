require 'spec_helper'

describe "white_lists/index" do
  before(:each) do
    assign(:white_lists, [
      stub_model(WhiteList,
        :name => "Name"
      ),
      stub_model(WhiteList,
        :name => "Name"
      )
    ])
  end

  it "renders a list of white_lists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
