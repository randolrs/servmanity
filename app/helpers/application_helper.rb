module ApplicationHelper

	def cp(path)
  		"active" if current_page?(path)
	end

	def google_map(center)
  		"https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=300x300&zoom=17"
	end

	def task_status_tag(status)
  		"Complete"
	end


end
