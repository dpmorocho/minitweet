require 'spec_helper'
	describe "User pages" do
	subject { page }
	describe "signup" do
		before { visit signup_path }

		let(:submit) { "Crear mi cuenta" }
		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name", with: "Diego Morocho"
				fill_in "Email", with: "dpmorocho@gmail.com"
				fill_in "Password", with: "mipass"
				fill_in "Confirmation", with: "mipass"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end
		end

		it { should have_selector('h1', text: 'Registro') }
		it { should have_selector('title', text: full_title('Registro')) }
	end
	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		it { should have_selector('h1', text: user.name) }
		it { should have_selector('title', text: user.name) }
	end
end