# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.MeetingForm
  constructor: ->
    @wireTopics()
    @wireTimeSlots()

  wireTopics: ->
    $('li.simple_topic').draggable({ revert: true })
    $('li.simple_topic').popover
      placement: 'left'
      trigger: 'hover'


  wireTimeSlots: =>
    $('fieldset.time_slot').droppable(
      drop: @topic_dropper
    )

  topic_dropper: (e,ui) ->
    id = $(ui.draggable).data('id')
    name = $(ui.draggable).find('.topic_title').text()
    volunteers = $(ui.draggable).data('volunteers')
    unless volunteers.length > 0
      volunteers = window.all_users 
    $(@).find('input[type=hidden]').val(id)
    $(@).find('.topic_title').text(name)
    options_string = for volunteer in volunteers
      "<option value='#{volunteer.id}'>#{volunteer.name}</option>"
    $(@).find('select').html(options_string.join("\n"))

$ ->
  if $('.meeting_form').length > 0
    new window.MeetingForm()