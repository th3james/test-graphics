window.Backbone ||= {}
window.Backbone.Controllers ||= {}

class Backbone.Controllers.MainController extends Backbone.Diorama.Controller
  constructor: ->
    # Make requests CORS by default
    $.defaultAjax = $.ajax
    $.ajax = (options) ->
      options.contentType ||= 'application/json'

      $.defaultAjax(options)

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
    @apiaryIndicators = new Backbone.Collections.ApiaryIndicatorCollection()

    apiaryIndicatorIndexView = new Backbone.Views.ApiaryIndicatorsIndexView(
      indicators: @apiary_indicator_collection
    )
    @mainRegion.showView(apiaryIndicatorIndexView)

    @changeStateOn(
    )
