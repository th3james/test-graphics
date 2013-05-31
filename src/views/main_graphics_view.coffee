window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MainGraphicsView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['main_graphics.hbs']

  initialize: (options) ->
    @render()

  render: ->
    # Close any existing views
    @closeSubViews()

    @$el.html(@template())

    # Render sub views into the elements created by subView helper in the template
    @renderSubViews()

    return @


  onClose: ->
    @closeSubViews()
