window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MapsView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['maps.hbs']

  initialize: (options) ->
    @mapIndicator = new Backbone.Models.MapIndicator(
      layerName: "ESRI_StateCityHighway_USA"
    )

  render: =>
    @closeSubViews()
    @$el.html(@template(model: @mapIndicator))
    @renderSubViews()

    return @

  onClose: ->
    @closeSubViews()
