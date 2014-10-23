Backbone = require "backbone"
$ = require 'jquery'
Backbone.$ = $
sd = require("sharify").data
mediator = require '../../../lib/mediator.coffee'
ConnectView = require '../../connect/client/connect_view.coffee'
LightboxView = require '../../lightbox/client/lightbox_view.coffee'

blockTemplate = -> require('../templates/block.jade') arguments...

module.exports = class BlockView extends Backbone.View
  autoRender: true
  container: null
  containerMethod: 'append'

  events:
    'click .grid__block__overlay' : 'openLightbox'
    'click .grid__block__connect-btn' : 'loadConnectView'

  initialize: (options)->
    @container = options.container if options.container?
    @autoRender = options.autoRender if options.autoRender?

    @render() if @autoRender
    @$el = $("##{@model.id}")

    mediator.on "model:#{@model.id}:updated", @update

    super

  loadConnectView: (e)=>
    e.preventDefault()
    e.stopPropagation()

    $connect_container = @$('.grid__block__connect-container')

    $connect_container.addClass 'is-active'
    new ConnectView
      el: $connect_container
      block: @block

  openLightbox: ->
    loc = window.location
    history.pushState "", document.title, loc.pathname + "#/show/#{@model.id}"
    @lbv = new LightboxView
      el: $('#l-lightbox-container')
      model: @model

  update: (model)=>
    $("##{model.id}").replaceWith blockTemplate(block: model)
    @$el = $("##{model.id}")
    @delegateEvents()

  render: =>
    @container[@containerMethod] blockTemplate(block: @model)