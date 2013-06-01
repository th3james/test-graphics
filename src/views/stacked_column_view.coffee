window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.StackedColumnView extends Backbone.Views.IndicatorGraphicView

  getCategoriesFromIndicator: ->
    xAxisField = @indicator.getXAxisField()

    categories = []
    for entry in @indicator.get('data')
      categories.push(entry[xAxisField])

    console.log categories
    return categories

  getSeriesFromIndicator: ->
    xAxisField = @indicator.getXAxisField()

    series = []

    for fieldName in @indicator.get('metadata').axes.y.fields
      group = {name: fieldName, data: []}
      for entry in @indicator.get('data')
        group.data.push entry[fieldName]
      series.push group

    console.log series
    return series

  drawGraph: ->
    return unless @indicator.get('metadata')?

    @$el.find("#container").highcharts(
      chart:
        type: "column"

      title:
        text: @indicator.getFullTitle()

      xAxis:
        categories: @getCategoriesFromIndicator()
        title:
          text: @indicator.get('metadata').axes.x.name

      yAxis:
        min: 0
        title:
          text: @indicator.get('metadata').axes.y.name

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
