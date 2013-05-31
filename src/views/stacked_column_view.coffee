window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.StackedColumnView extends Backbone.Views.IndicatorGraphicView

  getCategoriesFromIndicator: ->
    xAxisField = @indicator.getXAxisField()

    categories = []
    for entry in @indicator.get('data')
      categories.push(entry[xAxisField])
    return categories

  getSeriesFromIndicator: ->
    xAxisField = @indicator.getXAxisField()

    series = []

    if @indicator.get('data').length > 0
      for fieldName, value of @indicator.get('data')[0]
        if fieldName != xAxisField
          group = {name: fieldName, data: []}
          for entry in @indicator.get('data')
            group.data.push entry[fieldName]
          series.push group

    return series

  drawGraph: ->
    return unless @indicator.get('metadata')?

    @$el.find("#container").highcharts(
      chart:
        type: "column"

      title:
        text: "Stacked column chart"

      xAxis:
        categories: @getCategoriesFromIndicator()

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

      series: @getSeriesFromIndicator()
    )
