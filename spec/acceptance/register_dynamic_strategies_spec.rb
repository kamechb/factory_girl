require "spec_helper"

describe "register dynamic strategies" do
  it "allows registering custom strategies with a block" do
    define_class("User") do
      attr_accessor :name, :email, :avatar
    end

    define_class("Avatar") do
      attr_accessor :photo
    end

    FactoryGirl.define do
      factory :user do
        avatar
        name  "John Doe"
        email "person@example.com"
      end

      factory :avatar do
        photo "Awesome"
      end
    end

    FactoryGirl.register_dynamic_strategy(:awesome_hash) do
      association_strategy { :build }

      result do |evaluation|
        evaluation.object
      end
    end

    user = FactoryGirl.awesome_hash(:user)
    user.name.should == "John Doe"
    user.email.should == "person@example.com"
    user.avatar.photo.should == "Awesome"
  end
end
