window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ApiaryIndicatorsIndexView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['apiary_indicators_index.hbs']

  initialize: (options) ->
    @indicators = options.indicators
    @indicators.on('sync', @render)
    @indicators.fetch().fail((a,b,c)->
      console.log "uh oh!"
    )

  render: =>
    @closeSubViews()
    @$el.html(@template(
      thisView: @,
      indicators: @indicators.models
    ))
    @renderSubViews()

    return @

  onClose: ->
    @indicators.off('sync', @render)
    @closeSubViews()
