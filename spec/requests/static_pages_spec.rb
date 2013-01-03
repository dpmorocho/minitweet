require 'spec_helper' 
	describe "Static pages" do
		describe "Home" do
			it "should have the h1 'MiniTweet'" do
				visit '/static_pages/home'
				page.should have_selector('h1', :text => 'MiniTweet')
		end
		it "should have the base title" do 
			visit '/static_pages/home'
			page.should have_selector('title', :text => "MiniTweet VT")
		end
		it "should not have a custom page title" do 
			visit '/static_pages/home'
			page.should_not have_selector('title', :text => '| Home')
		end
	end

	describe "Help" do
		it "should have the h1 'Soporte'" do 
			visit '/static_pages/help' 
			page.should have_selector('h1', :text => 'Soporte')
		end
		it "should have the base title" do 
			visit '/static_pages/help'
			page.should have_selector('title', :text => "MiniTweet VT")
		end
		it "should not have a custom page title" do 
			visit '/static_pages/help'
			page.should_not have_selector('title', :text => '| Soporte')
		end
	end

	describe "About" do
		it "should have the h1 'Sobre VT'" do 
			visit '/static_pages/about' 
			page.should have_selector('h1', :text => 'Sobre VT')
		end
		it "should have the base title" do 
			visit '/static_pages/about'
			page.should have_selector('title', :text => "MiniTweet VT")
		end
		it "should not have a custom page title" do 
			visit '/static_pages/about'
			page.should_not have_selector('title', :text => '| Sobre VT')
		end
	end
end