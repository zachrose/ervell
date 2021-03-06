#
# General collection
#
Collection = require("chaplin").Collection
sd = require("sharify").data
_ = require 'underscore'
Model = require("../models/base.coffee")
ModelLib = require '../lib/model_lib.coffee'

module.exports = class Base extends Collection

  model:Model

  _.extend @prototype, ModelLib

  sync: (method, model, options) ->
    if sd.CURRENT_USER
      if !options.headers
        options.headers = {}
      options.headers['X-AUTH-TOKEN'] = sd.CURRENT_USER.authentication_token
    super

  fetchUntilEnd: (options = {}) ->
    page = options.data?.page - 1 or 0
    opts = _.clone(options)
    fetchPage = =>
      @fetch _.extend opts,
        data: _.extend (opts.data ? {}), page: page += 1
        remove: false
        complete: ->
        success: (col, res) =>
          options.each? col, res

          if res.length < page * 12
            options.success?(@)
            options.complete?(@)
          else
            fetchPage()
        error: ->
          options.error? arguments...
          options.complete?()
    fetchPage()

  initialize: (models, options={})->
    @setOptions(options)
    super

  next: (model) ->
    @at((@indexOf(model) + 1) % _.size(@models))

  prev: (model) ->
    index = @indexOf(model) - 1
    @at(if index > -1 then index else _.size(@models) - 1)

  last: ->
    @at @length - 1

  isEmpty: ->
    @models.length is 0
