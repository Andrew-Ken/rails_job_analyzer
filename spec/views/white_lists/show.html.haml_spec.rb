require 'spec_helper'

describe "white_lists/show" do
  before(:each) do
    @white_list = assign(:white_list, stub_model(WhiteList,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
