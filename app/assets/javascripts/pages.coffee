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

$(document).on('turbolinks:load', ready)