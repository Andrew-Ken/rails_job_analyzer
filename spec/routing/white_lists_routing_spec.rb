require "spec_helper"

describe WhiteListsController do
  describe "routing" do

    it "routes to #index" do
      get("/white_lists").should route_to("white_lists#index")
    end

    it "routes to #new" do
      get("/white_lists/new").should route_to("white_lists#new")
    end

    it "routes to #show" do
      get("/white_lists/1").should route_to("white_lists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/white_lists/1/edit").should route_to("white_lists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/white_lists").should route_to("white_lists#create")
    end

    it "routes to #update" do
      put("/white_lists/1").should route_to("white_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/white_lists/1").should route_to("white_lists#destroy", :id => "1")
    end

  end
end
