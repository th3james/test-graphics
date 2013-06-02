window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MainGraphicsView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['main_graphics.hbs']

  events:
    "click #switch-to-esri": "triggerSwitchToEsri"

  initialize: (options) ->
    @render()

  render: ->
    # Close any existing views
    @closeSubViews()

    @$el.html(@template(view: @))

    # Render sub views into the elements created by subView helper in the template
    @renderSubViews()

    return @

  triggerSwitchToEsri: ->
    @trigger('switchToEsri')

  onClose: ->
    @closeSubViews()
