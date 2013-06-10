window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ApiaryIndicatorsRowView extends Backbone.View
  template: Handlebars.templates['apiary_indicators_row.hbs']

  initialize: (options) ->
    @indicator = options.indicator
    @indicator.on('fetch', @render)
    @indicator.fetch()

  render: ->
    @$el.html(@template(indicator: @indicator.toJSON()))
    return @

  onClose: ->
    
