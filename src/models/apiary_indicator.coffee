window.Backbone.Models || = {}

class window.Backbone.Models.ApiaryIndicator extends Backbone.Model
  apiAddress: 'http://soerindicators.apiary.io'

  url: ->
    "#{@apiAddress}/indicators/#{@get('id')}/query?where=objectid+>+0&returnGeometry=false&outFields=LENGTH,TYPE&f=pjson"


  fetch: (options)->
    if !@metadata?
      @getMetadata(options)
    else
      super(options)

  getMetadata: (fetchOptions) ->
    $.ajax(
      url: "#{@apiAddress}/indicators/#{@get('id')}?f=pjson"
    ).done((data)=>
      @metadata = data
      @fetch(fetchOptions)
    ).fail((a,b,c) ->
      console.log "Error getting metadata!"
    )
