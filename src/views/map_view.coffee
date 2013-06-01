window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MapView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['map.hbs']

  initialize: (options) ->
    @mapIndicator = options.model

    @mapIndicator.fetchAllData(@render)

  render: =>
    @closeSubViews()
    if @mapIndicator.get('metadata')?
      @$el.html(@template(name: @mapIndicator.get('metadata').name, mapIndicator: @mapIndicator))
      @renderSubViews()
    return @

  onClose: ->
    @closeSubViews()
