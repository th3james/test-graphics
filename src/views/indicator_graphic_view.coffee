window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.IndicatorGraphicView extends Backbone.View
  template: Handlebars.templates['indicator_graphic.hbs']

  initialize: (options) ->
    @indicator = new Backbone.Models.Indicator(name: options.indicatorName)
    
    @indicator.fetchAllData(@render)

  render: =>
    @$el.html(@template(name: @indicator.get('name')))
    @drawGraph()
    return @

  onClose: ->
    
