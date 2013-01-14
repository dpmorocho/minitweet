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

			describe "after saving user" do
				before { click_button submit }
				let(:user) { User.find_by_email('dpmorocho@gmail.com') }
				it { should have_selector('title', text: user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Bienvenido') }
				it { should have_link('Salir') }
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

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit edit_user_path(user) }
		describe "page" do
			it { should have_selector('h1', text: "Actualizar Perfil") }
			it { should have_selector('title', text: "Editar Usuario") }
			it { should have_link('change', href: 'http://gravatar.com/emails') }
		end
		describe "with invalid information" do
			before { click_button "Guardar Cambios" }
			it { should have_content('error') }
		end
	end
end