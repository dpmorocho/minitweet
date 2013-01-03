module ApplicationHelper
	# El titulo en cada pagina.
	def full_title(page_title)
		base_title = "MiniTweet VT"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
end
