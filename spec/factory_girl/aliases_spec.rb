require 'spec_helper'

describe Factory, "aliases" do

  it "should include an attribute as an alias for itself by default" do
    FactoryGirl.aliases_for(:test).should include(:test)
  end

  it "should include the root of a foreign key as an alias by default" do
    FactoryGirl.aliases_for(:test_id).should include(:test)
  end

  it "should include an attribute's foreign key as an alias by default" do
    FactoryGirl.aliases_for(:test).should include(:test_id)
  end

  describe "after adding an alias" do

    before do
      Factory.alias(/(.*)_suffix/, '\1')
    end

    it "should return the alias in the aliases list" do
      FactoryGirl.aliases_for(:test_suffix).should include(:test)
    end

  end

end