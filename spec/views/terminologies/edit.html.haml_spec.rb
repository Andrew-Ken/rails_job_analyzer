require 'spec_helper'

describe "terminologies/edit" do
  before(:each) do
    @terminology = assign(:terminology, stub_model(Terminology,
      :job => nil,
      :terms => "MyText"
    ))
  end

  it "renders the edit terminology form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => terminologies_path(@terminology), :method => "post" do
      assert_select "input#terminology_job", :name => "terminology[job]"
      assert_select "textarea#terminology_terms", :name => "terminology[terms]"
    end
  end
end
