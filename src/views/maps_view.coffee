window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MapsView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['maps.hbs']

  initialize: (options) ->
    @mapIndicator = new Backbone.Models.MapIndicator(
      serviceName: "ESRI_StateCityHighway_USA",
      layer: 1
    )

  render: =>
    @closeSubViews()
    @$el.html(@template(model: @mapIndicator))
    @renderSubViews()

    return @

  onClose: ->
    @closeSubViews()
