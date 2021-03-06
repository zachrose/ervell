Backbone = require "backbone"
Backbone.$ = $
sd = require("sharify").data
Blocks = require '../../../collections/blocks.coffee'
Block = require '../../../models/block.coffee'
Channel = require '../../../models/channel.coffee'

newBlockTemplate = -> require('../templates/new_block.jade') arguments...

module.exports = class NewBlockView extends Backbone.View

  events:
    'click .grid__block--new-block__plus_button' : 'showAddBlockForm'
    'click .grid__block--new-block__cancel' : 'cancelForm'
    'click .grid__block--new-block__submit' : 'createBlock'

  initialize: (options)->
    @blocks = options.blocks
    @$container = options.container
    @$field = @$('.grid__block--new-block__content-field')

    @render() if options.autoRender

  showAddBlockForm: ->
    @$el.addClass 'active'
    @$('.grid__block--new-block__add-block').addClass 'active'

  cancelForm: (e)->
    $parent = $(e.target).closest('.grid__block--new-block__form')
    @$el.removeClass 'active'
    $parent.removeClass 'active'

  isURL: ->
    string = @$field.val()
    urlregex = /^((ht{1}tp(s)?:\/\/)[-a-zA-Z0-9@:,!$%_\+.~#?&\(\)\/\/=]+)$/
    urlregex.test(string)

  fieldIsntEmpty: ->
    @$field.val() isnt ""

  createBlock: ->
    if @fieldIsntEmpty()
      block = new Block

      if @isURL()
        block.set source: @$field.val(), { silent: true }
      else
        block.set content: @$field.val(), { silent: true }

      console.log 'our new block', block.toJSON(), @blocks, @blocks.create

      @blocks.create block.toJSON(),
        url: "#{sd.API_URL}/channels/#{@model.get('slug')}/blocks"
        wait: true
        success: (block) =>
          @$field.val ""
          @$field.blur()

  render: ->
    @$container.prepend newBlockTemplate(channel: @model)
