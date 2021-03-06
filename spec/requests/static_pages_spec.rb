require 'spec_helper' 
	describe "Static pages" do
		
		subject { page }
		
		describe "Home" do
			before { visit root_path }
			it { should have_selector('h1', text: 'MiniTweet') }
			it { should have_selector('title', text: full_title('')) }
			it { should_not have_selector 'title', text: '| Home' }

			describe "for signed-in users" do
				let(:user) { FactoryGirl.create(:user) }
				before do
					FactoryGirl.create(:micropost, user: user, content: "mini tweet")
					FactoryGirl.create(:micropost, user: user, content: "publicacion ejemplo")
					sign_in user
					visit root_path
				end
				it "should render the user's feed" do
					user.feed.each do |item|
						page.should have_selector("li##{item.id}", text: item.content)
					end
				end

				describe "follower/following counts" do
					let(:other user) { FactoryGirl.create(:user) }
					before do
						other_user.follow!(user)
						visit root_path
					end
					it { should have_link("0 Siguiendo", href: following_user_path(user)) }
					it { should have_link("1 Seguidor", href: followers_user_path(user)) }
				end
			end
		end
	

		describe "Help" do
			before { visit help_path }
			it { should have_selector('h1', text: 'Soporte') }
			it { should have_selector('title', text: full_title('')) }
		end
		

	describe "Contact" do
		before { visit contact_path }
		it { should have_selector('h1', text: 'Contactos') }
		it { should have_selector('title', text: full_title('')) }
	end

	describe "About" do
		before { visit about_path }
		it { should have_selector('h1', text: 'Sobre VT') }
		it { should have_selector('title', text: full_title('')) }
	end
end