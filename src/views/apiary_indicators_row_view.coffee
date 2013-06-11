window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ApiaryIndicatorsRowView extends Backbone.Diorama.NestingView
  template: Handlebars.templates['apiary_indicators_row.hbs']

  initialize: (options) ->
    @indicator = options.indicator
    @indicator.on('resultsSync', @render)
    @indicator.getResults()

  render: =>
    @closeSubViews()
    @$el.html(@template(
      thisView: @,
      indicatorName: @indicator.get('name'),
      indicator: @indicator,
      results: @indicator.results
    ))
    @renderSubViews()
    return @

  onClose: ->
    @closeSubViews()
    @indicator.off('fetch', @render)
    @indicator.off('resultsSync', @render)
