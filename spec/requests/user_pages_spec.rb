require 'spec_helper'
	describe "User pages" do
	subject { page }
	describe "signup" do
		before { visit signup_path }
		it { should have_selector('h1', text: 'Registro') }
		it { should have_selector('title', text: full_title('Registro')) }
	end
end