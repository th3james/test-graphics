window.Backbone.Models || = {}

class window.Backbone.Models.MapIndicator extends Backbone.Models.Indicator
  initialize: (options) ->
    @layerName = options.layerName

  getMetadata: (successCallback) ->
    $.ajax(
      url: "json/map_indicators/#{@get('layerName')}/MapServer.json"
    ).done(successCallback).fail((a,b,c) ->
      console.log "Error getting metdata!"
    )

  getData: (successCallback) ->
    $.ajax(
      url: "json/map_indicators/#{@get('layerName')}/MapServer/find.json"
    ).done(successCallback)
