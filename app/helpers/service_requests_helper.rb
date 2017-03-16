module ServiceRequestsHelper

	def task_status_tag(request)
  		
  		if request.status == "Complete"
  			"Complete"
  		else
  			"Scheduled"
  		end

	end

	def request_time_and_date(request)
  		
  		request.time_of_day + " of " + request.scheduled_day.strftime("%a, %B %d")

	end


end
