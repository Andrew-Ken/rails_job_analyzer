require 'spec_helper'

describe "reviews/new" do
  before(:each) do
    assign(:review, stub_model(Review,
      :job => nil,
      :memo => "MyText",
      :rank => 1,
      :applied => false
    ).as_new_record)
  end

  it "renders new review form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reviews_path, :method => "post" do
      assert_select "input#review_job", :name => "review[job]"
      assert_select "textarea#review_memo", :name => "review[memo]"
      assert_select "input#review_rank", :name => "review[rank]"
      assert_select "input#review_applied", :name => "review[applied]"
    end
  end
end
