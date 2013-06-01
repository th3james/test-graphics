window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MapView extends Backbone.View
  template: Handlebars.templates['map.hbs']

  initialize: (options) ->
    @mapIndicator = options.model

    @mapIndicator.fetchAllData(@render)

  render: =>
    if @mapIndicator.get('metadata')?
      @$el.html(@template(name: @mapIndicator.get('metadata').name, mapIndicator: @mapIndicator))
    return @

  onClose: ->
    
