window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.IndicatorGraphicView extends Backbone.View
  template: Handlebars.templates['indicator_graphic.hbs']

  initialize: (options) ->
    @indicator = new Backbone.Models.Indicator(name: options.indicatorName)
    
    @indicator.fetchAllData(@render)

  render: =>
    @$el.html(@template())
    @drawGraph()
    return @

  drawGraph: ->
    return unless @indicator.get('metadata')?

    @$el.find("#container").highcharts(
      chart:
        type: "column"

      title:
        text: "Stacked column chart"

      xAxis:
        categories: @indicator.getCategories()

      yAxis:
        min: 0
        title:
          text: "Total fruit consumption"

        stackLabels:
          enabled: true
          style:
            fontWeight: "bold"
            color: (Highcharts.theme and Highcharts.theme.textColor) or "gray"

      legend:
        align: "right"
        x: -100
        verticalAlign: "top"
        y: 20
        floating: true
        backgroundColor: (Highcharts.theme and Highcharts.theme.legendBackgroundColorSolid) or "white"
        borderColor: "#CCC"
        borderWidth: 1
        shadow: false

      tooltip:
        formatter: ->
          "<b>" + @x + "</b><br/>" + @series.name + ": " + @y + "<br/>" + "Total: " + @point.stackTotal

      plotOptions:
        column:
          stacking: "normal"
          dataLabels:
            enabled: true
            color: (Highcharts.theme and Highcharts.theme.dataLabelsColor) or "white"

      series: @indicator.getSeries()
    )

  onClose: ->
    
