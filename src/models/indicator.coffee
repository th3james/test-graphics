window.Backbone.Models || = {}

class window.Backbone.Models.Indicator extends Backbone.Model
  defaults:
    name: ''
    metadata: null
    data: null

  fetchAllData: (successCallback) ->
    @getMetadata((metadata)=>
      @set('metadata', metadata)
      @getData((data)=>
        @set('data', data)
        successCallback()
      )
    )

  getMetadata: (successCallback) ->
    $.ajax(
      url: "json/indicators/#{@get('name')}/metadata.json"
    ).done(successCallback).fail((a,b,c) ->
      console.log "Error getting metdata!"
    )

  getData: (successCallback) ->
    $.ajax(
      url: "json/indicators/#{@get('name')}.json"
    ).done(successCallback)

  getFullTitle: ->
    "#{@get('metadata')['full name']} (#{@get('metadata')["date published"]})"

  getXAxisField: ->
    @get('metadata').axes.x.fields[0]

  getYAxisField: ->
    @get('metadata').axes.y.fields[0]

