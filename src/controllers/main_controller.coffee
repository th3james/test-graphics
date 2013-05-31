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
    #  {event: 'someEvent', publisher: graphicsView, newState: @anotherState}
    )

