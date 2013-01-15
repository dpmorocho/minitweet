require 'spec_helper'
	describe "User pages" do
	subject { page }

	describe "index" do
		#before do
			#sign_in FactoryGirl.create(:user)
			#FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
			#FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
			#visit users_path
		#end
		let(:user) { FactoryGirl.create(:user) }
		before(:each) do
			sign_in user
			visit users_path
		end

		it { should have_selector('title', text: 'Todos los Usuarios') }
		it { should have_selector('h1', text: 'Todos los Usuarios') }

		describe "pagination" do
			it { should have_selector('div.pagination') }
			
			it "should list each user" do
				User.paginate(page:).each do |user|
					page.should have_selector('li', text: user.name)
				end
			end
		end

		describe "delete links" do
			it { should _not have_link('borrar') }
			describe "as an admin user" do
				#let(:admin) { FactoryGirl.create(:admin) }
				before do
					sign_in admin
					visit users_path
				end
				it { should have_link('borrar', href: user_path(User.first)) }
				it "should be able to delete another user" do
					expect { click_link('borrar') }.to change(User, :count).by(-1)
				end
				it { should_not have_link('borrar', href: user_path(admin)) }
			end
		end

		it "should list each user" do
			User.all.each do |user|
				page.should have_selector('li', text: user.name)
			end
		end
	end

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
		let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "mini") }
    	let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "tweet") }
		before { visit user_path(user) }
		it { should have_selector('h1', text: user.name) }
		it { should have_selector('title', text: user.name) }
		describe "microposts" do
			it { should have_content(m1.content) }
			it { should have_content(m2.content) }
			it { should have_content(user.microposts.count) }
		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user)
		end
			
		end
		describe "with invalid information" do
			before { click_button "Guardar Cambios" }
			it { should have_content('error') }
		end
		describe "with valid information" do
			let(:new name) { "Nuevo Nombre" }
			let(:new email) { "nuevo@ejemplo.com" }
			before do
				fill_in "Name" , with: new_name
				fill_in "Email" , with: new_email
				fill_in "Password", with: user.password
				fill_in "confirm Password", with: user.password
				click_button "Guardar Cambios"
			end
			it { should have_selector('title', text: new_name) }
			it { should have_selector('div.alert.alert-success') }
			it { should have_link('Salir', href: signout_path) }
			specify { user.reload.name.should == new_name }
			specify { user.reload.email.should == new_email }
		end
	end
end