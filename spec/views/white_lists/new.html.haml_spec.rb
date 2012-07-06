require 'spec_helper'

describe "white_lists/new" do
  before(:each) do
    assign(:white_list, stub_model(WhiteList,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new white_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => white_lists_path, :method => "post" do
      assert_select "input#white_list_name", :name => "white_list[name]"
    end
  end
end
