window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.PieChartView extends Backbone.Views.IndicatorGraphicView

  getSeriesFromIndicator: ->
    xAxisField = @indicator.getXAxisField()
    yAxisField = @indicator.getYAxisField()

    series = []

    for entry in @indicator.get('data')
      series.push [entry[xAxisField], entry[yAxisField]]

    return series

  drawGraph: ->
    return unless @indicator.get('metadata')?

    @$el.find("#container").highcharts
      chart:
        plotBackgroundColor: null
        plotBorderWidth: null
        plotShadow: false

      title:
        text: @indicator.get('name')

      tooltip:
        pointFormat: "{series.name}: <b>{point.percentage}%</b>"
        percentageDecimals: 1

      plotOptions:
        pie:
          allowPointSelect: true
          cursor: "pointer"
          dataLabels:
            enabled: true
            color: "#000000"
            connectorColor: "#000000"
            formatter: ->
              "<b>" + @point.name + "</b>: " + @percentage + " %"

      series: [
        type: "pie"
        name: @indicator.get('name')
        data: @getSeriesFromIndicator()
      ]
