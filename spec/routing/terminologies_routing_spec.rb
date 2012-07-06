require "spec_helper"

describe TerminologiesController do
  describe "routing" do

    it "routes to #index" do
      get("/terminologies").should route_to("terminologies#index")
    end

    it "routes to #new" do
      get("/terminologies/new").should route_to("terminologies#new")
    end

    it "routes to #show" do
      get("/terminologies/1").should route_to("terminologies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/terminologies/1/edit").should route_to("terminologies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/terminologies").should route_to("terminologies#create")
    end

    it "routes to #update" do
      put("/terminologies/1").should route_to("terminologies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/terminologies/1").should route_to("terminologies#destroy", :id => "1")
    end

  end
end
