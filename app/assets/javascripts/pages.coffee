# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

		$(".geocomplete-input").geocomplete()

		$(".modal-cta").click (e) ->
			targetId = "#" + $(@).data("modal-id")
			$('body').find(targetId).fadeIn()
			$('body').addClass('no-scroll')
			$('.menu-content').animate({width:'show'},350);

		$(".dismiss-modal").click (e) ->
			$('body').removeClass('no-scroll')
			$('.modal-container').fadeOut()

		$(".modal-content").click (e) ->
			e.stopPropagation()

		$(".clear-on-focus").click (e) ->
			$(@).val('')

		$(".make-live").click (e) ->
			$("input#is_live").val("true")

		$(".make-not-live").click (e) ->
			$("input#is_live").val("false")

		$(".date-toggle").click (e) ->
			me = $(@)
			available = me.data("available")
			if me.hasClass("available")
				me.addClass("unavailable")
				me.removeClass("available")
			else
				me.addClass("available")
				me.removeClass("unavailable")

		$(".modal-container").click (e) ->
			$(@).fadeOut()
			$('body').removeClass('no-scroll')
			$('.menu-content').animate({width:'hide'},350);

		$(".menu-content").click (e) ->
			e.stopPropagation()

		$(".button").click (e) ->
			e.stopPropagation()

		$(".click-to-reveal").click (e) ->
			$('.click-to-reveal').removeClass('active')
			$('div.reveal-panel').hide()
			$(@).addClass('active')
			targetId = "#" + $(@).data("reveal-panel-id")
			$('body').find(targetId).fadeIn()
			$('.click-to-reveal').each (index, element) =>
				if $(element).data("reveal-panel-id") == $(@).data("reveal-panel-id")
					$(element).addClass('active')

		$(".hide-cc-form").click (e) ->
			$('#newCCForm').slideUp()

		$(".show-cc-form").click (e) ->
			$('#newCCForm').slideDown()

		$(".add-a-card").click (e) ->
			$('#cc-form').fadeIn()

		@checkForRequestAcceptance = (requestID) ->
			$.ajax
				url: "/service_request/check_for_acceptance/#{requestID}", format: 'js'
				type: "GET"
				success: (data) ->
		  			console.log(data)
		  			if data.accepted
		  				window.location.href = data.redirect_to_url

		$(".fill-input").click (e) ->
			$(@).parent().parent().find('.fill-input').removeClass('active')
			$(@).addClass('active')
			targetId = "#" + $(@).data("input-id")
			value = $(@).data("input-value")
			$('body').find(targetId).val(value)

		$('.change-time-label').click (e) ->
			dt = new Date
			hidden_input = $(@).parent().find('.form-controller-input')
			date_label = $(@).parent().find('.time-label')
			change_interval = $(@).data("change-interval")
			input_date = new Date
			input_date.setDate(hidden_input.val())
			inputval = hidden_input.val()
			inputval = inputval.split("-")
			year = inputval[0]
			month = inputval[1]
			day = inputval[2]
			datestring = year + "," + month + "," + day
			dateval = new Date(datestring)
			new_date = new Date(datestring)
			new_date.setDate(new_date.getDate() + change_interval)
			day = ("0" + new_date.getDate()).slice(-2)
			month = ("0" + (new_date.getMonth() + 1)).slice(-2)
			new_date_value = new_date.getFullYear()+"-"+(month)+"-"+(day)
			new_date_string = new_date.toString().split(" ")
			date_label.text(new_date_string[0] + ", " + new_date_string[1] + " " + new_date_string[2] )
			hidden_input.val(new_date_value)

$(document).on('turbolinks:load', ready)