window.Backbone.Models || = {}

class window.Backbone.Models.MapIndicator extends Backbone.Models.Indicator
  initialize: (options) ->
    @serviceName = options.serviceName
    @layer = options.layer

  getFullTitle: ->
    @get('metadata').name

  getMetadata: (successCallback) ->
    $.ajax(
      url: "json/map_indicators/#{@get('serviceName')}/MapServer/#{@get('layer')}.json"
    ).done(successCallback).fail((a,b,c) ->
      console.log "Error getting metdata!"
    )

  getData: (successCallback) ->
    $.ajax(
      url: "json/map_indicators/#{@get('serviceName')}/MapServer/#{@get('layer')}/find.json"
    ).done(successCallback)

  getWMSAddress: ->
    "http://sampleserver1.arcgisonline.com/ArcGIS/services/Specialty/#{@serviceName}/MapServer/WMSServer"
