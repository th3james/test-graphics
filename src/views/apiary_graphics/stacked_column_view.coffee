window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.ApiaryStackedColumnView extends Backbone.View

  initialize: (options) ->
    @indicator = options.indicator

    @render()

  render: =>
    @drawGraph()
    return @

  getCategoriesFromIndicator: ->
    xAxisField = @indicator.getXAxisField()

    categories = []
    for entry in @indicator.results.features
      categories.push(entry.attributes[xAxisField])

    console.log categories
    return categories

  getSeriesFromIndicator: ->
    xAxisField = @indicator.getXAxisField()

    series = []

    fieldName = @indicator.getYAxisField()
    group = {name: fieldName, data: []}
    for entry in @indicator.results.features
      group.data.push parseFloat(entry.attributes[fieldName], 10)
    series.push group

    console.log series
    return series

  drawGraph: ->
    @$el.highcharts(
      chart:
        type: "column"

      title:
        text: @indicator.get('name')

      xAxis:
        categories: @getCategoriesFromIndicator()
        title:
          text: @indicator.getXAxisField()

      yAxis:
        min: 0
        title:
          text: @indicator.getYAxisField()

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

      series: @getSeriesFromIndicator()
    )
