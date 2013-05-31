window.Backbone ||= {}
window.Backbone.Controllers ||= {}

class Backbone.Controllers.MainController extends Backbone.Diorama.Controller
  constructor: ->
    @mainRegion = new Backbone.Diorama.ManagedRegion()
    $('body').append(@mainRegion.$el)
    
    # Default state
    @graphics()


  graphics: =>
    graphicsView = new Backbone.Views.MainGraphicsView()
    @mainRegion.showView(graphicsView)

    ###
      @changeStateOn maps events published by other objects to
      controller states
    ###
    @changeStateOn(
    #  {event: 'someEvent', publisher: graphicsView, newState: @anotherState}
    )



window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.MainGraphicsView extends Backbone.View
  template: Handlebars.templates['main_graphics.hbs']

  initialize: (options) ->
    @render()

  render: ->
    @$el.html(@template())
    @drawGraph()
    return @

  getGraphData: (successCallback) ->

  drawGraph: ->
    categories = series = []
    @$el("#container").highcharts(
    .$el.find("#container").highcharts(
      chart:
        type: "column"

      title:
        text: "Stacked column chart"

      xAxis:
        categories: categories

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

      series: series
    )

  onClose: ->
    
