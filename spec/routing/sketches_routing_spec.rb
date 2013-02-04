require "spec_helper"

describe SketchesController do
  describe "routing" do

    it "routes to #index" do
      get("/sketches").should route_to("sketches#index")
    end

    it "routes to #new" do
      get("/sketches/new").should route_to("sketches#new")
    end

    it "routes to #show" do
      get("/sketches/1").should route_to("sketches#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sketches/1/edit").should route_to("sketches#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sketches").should route_to("sketches#create")
    end

    it "routes to #update" do
      put("/sketches/1").should route_to("sketches#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sketches/1").should route_to("sketches#destroy", :id => "1")
    end

  end
end
