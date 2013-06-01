window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.EsriMapIndicatorGraphicView extends Backbone.View
  template: Handlebars.templates['indicator_graphic.hbs']

  initialize: (options) ->
    @indicator = options.mapIndicator

    @render()

  render: =>
    @$el.html(@template(name: @indicator.get('metadata').name))
    @drawGraph()
    return @

  onClose: ->
    
