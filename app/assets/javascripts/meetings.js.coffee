# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.MeetingForm
  constructor: ->
    @wireTopics()
    @wireTimeSlots()

  wireTopics: ->
    $('li.simple_topic').draggable({ revert: true })

  wireTimeSlots: ->
    $('fieldset.time_slot').droppable(
      drop: (e,ui) ->
        id = $(ui.draggable).data('id')
        name = $(ui.draggable).find('.topic_title').text()
        $(@).find('input[type=hidden]').val(id)
        $(@).find('.topic_title').text(name)
    )

$ ->
  if $('.meeting_form').length > 0
    new window.MeetingForm()