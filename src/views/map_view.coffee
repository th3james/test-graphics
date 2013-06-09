window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MapView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['map.hbs']

  initialize: (options) ->
    @esriIndicator = options.model

    @esriIndicator.fetchAllData(@render)

  render: =>
    if @esriIndicator.get('metadata')?
      @closeSubViews()
      @$el.html(@template(view: @, name: @esriIndicator.get('metadata').name, esriIndicator: @esriIndicator))
      @renderSubViews()
      window.mapView = @
    return @

  onClose: ->
    @closeSubViews()
