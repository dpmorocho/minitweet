require 'spec_helper' 
	describe "Static pages" do
		
		subject { page }
		
		describe "Home" do
			before { visit root_path }
			it { should have_selector('h1', text: 'MiniTweet') }
			it { should have_selector('title', text: full_title('')) }
			it { should_not have_selector 'title', text: '| Home' }
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