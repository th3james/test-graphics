window.Backbone ||= {}
window.Backbone.Controllers ||= {}

class Backbone.Controllers.MainController extends Backbone.Diorama.Controller
  constructor: ->
    @mainRegion = new Backbone.Diorama.ManagedRegion()
    $('body').append(@mainRegion.$el)
    
    # Default state
    @graphics()


  graphics: =>
    graphicsView = new Backbone.Views.MainGraphicsView()
    @mainRegion.showView(graphicsView)

    ###
      @changeStateOn maps events published by other objects to
      controller states
    ###
    @changeStateOn(
      {event: 'switchToMaps', publisher: graphicsView, newState: @maps}
    )

  maps: =>
    mapsView = new Backbone.Views.MapsView()
    @mainRegion.showView(mapsView)

    ###
      @changeStateOn maps events published by other objects to
      controller states
    ###
    @changeStateOn(
      {event: 'switchToGraphics', publisher: mapsView, newState: @graphics}
    )
