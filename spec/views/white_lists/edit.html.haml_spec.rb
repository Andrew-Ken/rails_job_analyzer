require 'spec_helper'

describe "white_lists/edit" do
  before(:each) do
    @white_list = assign(:white_list, stub_model(WhiteList,
      :name => "MyString"
    ))
  end

  it "renders the edit white_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => white_lists_path(@white_list), :method => "post" do
      assert_select "input#white_list_name", :name => "white_list[name]"
    end
  end
end
