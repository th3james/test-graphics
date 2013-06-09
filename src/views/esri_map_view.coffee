window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.EsriMapView extends Backbone.View
  template: Handlebars.templates['esri_map.hbs']

  initialize: (options) ->
    @esriIndicator = options.esriIndicator

  render: =>
    @$el.html(@template())
    @createMap()
    return @
  
  createMap: ->
    # create a map in the "map" div, set the view to a given place and zoom
    @map = L.map(
      @$el.find(".map")[0],
        scrollWheelZoom: false
    ).setView([41.508577,-99.84375], 5)
    
    # add an OpenStreetMap tile layer
    L.tileLayer(
      "http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png"
    ).addTo @map

    # Add map indicator layer
    L.tileLayer.wms(@esriIndicator.getWMSAddress(),
      layers: @esriIndicator.layer,
      format: 'image/png',
      transparent: true
    ).addTo @map

  onClose: ->
    
