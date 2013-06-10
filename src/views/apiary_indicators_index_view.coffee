window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ApiaryIndicatorsIndexView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['apiary_indicators_index.hbs']

  initialize: (options) ->
    @indicators = options.indicators
    @render()

  render: =>
    @closeSubViews()
    @$el.html(@template(
      thisView: @,
      indicators: @indicators
    ))
    @renderSubViews()

    return @

  onClose: ->
    @closeSubViews()
