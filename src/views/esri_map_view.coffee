window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.EsriMapView extends Backbone.View
  template: Handlebars.templates['esri_map.hbs']

  initialize: (options) ->
    @mapIndicator = options.mapIndicator
    @render()

  render: ->
    @$el.html(@template())
    @createMap()
    return @
  
  createMap: ->
    # create a map in the "map" div, set the view to a given place and zoom
    @map = L.map(@$el.find(".map")[0]).setView([41.508577,-99.84375], 5)
    
    # add an OpenStreetMap tile layer
    L.tileLayer("http://{s}.tile.osm.org/{z}/{x}/{y}.png",
      attribution: "&copy; <a href=\"http://osm.org/copyright\">OpenStreetMap</a> contributors"
    ).addTo @map

    # Add map indicator layer
    L.tileLayer.wms(@mapIndicator.getWMSAddress(),
      layers: @mapIndicator.layer,
      format: 'image/png',
      transparent: true
    ).addTo @map

  onClose: ->
    
