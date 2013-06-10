window.Backbone ||= {}
window.Backbone.Collections ||= {}

class Backbone.Collections.ApiaryIndicatorCollection extends Backbone.Collection
  model: Backbone.Models.ApiaryIndicator

  apiAddress: 'http://wcmcindicatorapi.apiary.io'

  url: ->
    "#{@apiAddress}/indicators"

  parse: (data) ->
    return data.indicators
