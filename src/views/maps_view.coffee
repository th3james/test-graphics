window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MapsView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['maps.hbs']

  events:
    "click #switch-to-environment": "triggerSwitchToEnvironment"

  initialize: (options) ->
    @esriIndicators = []
    @esriIndicators.push new Backbone.Models.EsriIndicator(
      serviceName: "ESRI_StateCityHighway_USA",
      layer: 1
    )
    @esriIndicators.push new Backbone.Models.EsriIndicator(
      serviceName: "ESRI_StateCityHighway_USA",
      layer: 0
    )

  render: =>
    @closeSubViews()
    @$el.html(@template(view: @, models: @esriIndicators))
    @renderSubViews()

    return @

  triggerSwitchToEnvironment: =>
    @trigger('switchToEnvironment')

  onClose: ->
    @closeSubViews()
