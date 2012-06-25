require 'spec_helper'

describe "jobs/new" do
  before(:each) do
    assign(:job, stub_model(Job,
      :name => "MyString",
      :company => "MyString",
      :location => "MyString",
      :content => "MyText",
      :web_source => "MyString"
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path, :method => "post" do
      assert_select "input#job_name", :name => "job[name]"
      assert_select "input#job_company", :name => "job[company]"
      assert_select "input#job_location", :name => "job[location]"
      assert_select "textarea#job_content", :name => "job[content]"
      assert_select "input#job_web_source", :name => "job[web_source]"
    end
  end
end
