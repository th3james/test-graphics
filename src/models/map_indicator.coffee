window.Backbone.Models || = {}

class window.Backbone.Models.MapIndicator extends Backbone.Models.Indicator
  initialize: (options) ->
    @serviceName = options.serviceName
    @layer = options.layer

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
