require 'spec_helper'

describe "jobs/show" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :name => "Name",
      :company => "Company",
      :location => "Location",
      :content => "MyText",
      :web_source => "Web Source"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Company/)
    rendered.should match(/Location/)
    rendered.should match(/MyText/)
    rendered.should match(/Web Source/)
  end
end
