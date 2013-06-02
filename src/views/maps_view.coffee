window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MapsView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['maps.hbs']

  events:
    "click #switch-to-environment": "triggerSwitchToEnvironment"

  initialize: (options) ->
    @mapIndicators = []
    @mapIndicators.push new Backbone.Models.MapIndicator(
      serviceName: "ESRI_StateCityHighway_USA",
      layer: 1
    )
    @mapIndicators.push new Backbone.Models.MapIndicator(
      serviceName: "ESRI_StateCityHighway_USA",
      layer: 0
    )

  render: =>
    @closeSubViews()
    @$el.html(@template(view: @, models: @mapIndicators))
    @renderSubViews()

    return @

  triggerSwitchToEnvironment: =>
    @trigger('switchToEnvironment')

  onClose: ->
    @closeSubViews()
