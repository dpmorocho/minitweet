require 'spec_helper' 
	describe "Static pages" do
		describe "Home" do
			it "should have the h1 'MiniTweet'" do
				visit '/static_pages/home'
				page.should have_selector('h1', :text => 'MiniTweet')
		end
		it "should have the title 'MiniTweet'" do 
			visit '/static_pages/home'
			page.should have_selector('title', :text => "MiniTweet VT | Home")
		end
	end

	describe "Help" do
		it "should have the h1 'Soporte'" do 
			visit '/static_pages/help' 
			page.should have_selector('h1', :text => 'Soporte')
		end
		it "should have the title 'Soporte'" do 
			visit '/static_pages/help'
			page.should have_selector('title', :text => "MiniTweet VT | Soporte")
		end
	end

	describe "About" do
		it "should have the h1 'Sobre VT'" do 
			visit '/static_pages/about' 
			page.should have_selector('h1', :text => 'Sobre VT')
		end
		it "should have the title 'Sobre VT'" do 
			visit '/static_pages/about'
			page.should have_selector('title', :text => "MiniTweet VT | Sobre VT")
		end
	end
end