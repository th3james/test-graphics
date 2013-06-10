window.Backbone ||= {}
window.Backbone.Controllers ||= {}

class Backbone.Controllers.MainController extends Backbone.Diorama.Controller
  constructor: ->
    @mainRegion = new Backbone.Diorama.ManagedRegion()
    $('body').append(@mainRegion.$el)
    
    # Default state
    @apiary()


  environment: =>
    graphicsView = new Backbone.Views.MainGraphicsView()
    @mainRegion.showView(graphicsView)

    @changeStateOn(
      {event: 'switchToEsri', publisher: graphicsView, newState: @esri}
    )

  esri: =>
    mapsView = new Backbone.Views.MapsView()
    @mainRegion.showView(mapsView)

    @changeStateOn(
      {event: 'switchToEnvironment', publisher: mapsView, newState: @environment}
    )

  apiary: =>
    @apiaryIndicators = []
    @apiaryIndicators.push new Backbone.Models.ApiaryIndicator(
      id: 1
    )

    apiaryIndicatorIndexView = new Backbone.Views.ApiaryIndicatorsIndexView(
      indicators: @apiaryIndicators
    )
    @mainRegion.showView(apiaryIndicatorIndexView)

    @changeStateOn(
    )
