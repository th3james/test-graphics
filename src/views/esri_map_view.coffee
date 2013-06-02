window.Backbone ||= {}
window.Backbone.Views ||= {}

class Backbone.Views.EsriMapView extends Backbone.View
  template: Handlebars.templates['esri_map.hbs']

  initialize: (options) ->
    @mapIndicator = options.mapIndicator

  render: =>
    @$el.html(@template())
    @createMap()
    console.log "#{@constructor.name}.#{@cid}: #{@mapIndicator.get('metadata').name} rendered"
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
    L.tileLayer.wms(@mapIndicator.getWMSAddress(),
      layers: @mapIndicator.layer,
      format: 'image/png',
      transparent: true
    ).addTo @map

  onClose: ->
    
