# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
		
	jQuery ->

		$(".modal-cta").click (window.event), ->
			targetId = "#" + $(@).data("modal-id")
			$('body').find(targetId).show()
			$('body').addClass('no-scroll')
			$('.menu-content').animate({width:'show'},350);

		$(".modal-container").click (window.event), ->
			$(@).hide()
			$('body').removeClass('no-scroll')
			$('.menu-content').animate({width:'hide'},350);

		$(".menu-content").click (window.event), ->
			window.event.stopPropagation()

		$(".click-to-reveal").click (window.event), ->
			$('a.click-to-reveal').removeClass('active')
			$('div.reveal-panel').hide()
			$(@).addClass('active')
			targetId = "#" + $(@).data("reveal-panel-id")
			$('body').find(targetId).slideDown()

		$(".fill-input").click (window.event), ->
			$(@).parent().parent().find('.fill-input').removeClass('active')
			$(@).addClass('active')
			targetId = "#" + $(@).data("input-id")
			value = $(@).data("input-value")
			$('body').find(targetId).val(value)

		$('.change-time-label').click (window.event), ->
			dt = new Date
			new_date = new Date
			label_date = new Date
			today = new Date
			label_date = $(@).parent().find('.time-label').data("label-time")
			dt = today.getDate() + 1
			change_interval = $(@).data("change-interval")
			alert(label_date)

$(document).on('turbolinks:load', ready)