require 'spec_helper'

describe "teams/show" do
  before(:each) do
    @team = assign(:team, stub_model(Team,
      :name => "Name",
      :poule => "Poule"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Poule/)
  end
end
