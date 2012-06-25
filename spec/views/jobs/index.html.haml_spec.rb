require 'spec_helper'

describe "jobs/index" do
  before(:each) do
    assign(:jobs, [
      stub_model(Job,
        :name => "Name",
        :company => "Company",
        :location => "Location",
        :content => "MyText",
        :web_source => "Web Source"
      ),
      stub_model(Job,
        :name => "Name",
        :company => "Company",
        :location => "Location",
        :content => "MyText",
        :web_source => "Web Source"
      )
    ])
  end

  it "renders a list of jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Web Source".to_s, :count => 2
  end
end
