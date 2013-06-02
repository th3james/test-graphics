window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MapView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['map.hbs']

  initialize: (options) ->
    @mapIndicator = options.model

    @mapIndicator.fetchAllData(@render)

  render: =>
    if @mapIndicator.get('metadata')?
      @closeSubViews()
      @$el.html(@template(view: @, name: @mapIndicator.get('metadata').name, mapIndicator: @mapIndicator))
      @renderSubViews()
      window.mapView = @
    return @

  onClose: ->
    @closeSubViews()
