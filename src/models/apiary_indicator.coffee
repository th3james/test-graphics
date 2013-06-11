window.Backbone.Models || = {}

class window.Backbone.Models.ApiaryIndicator extends Backbone.Model
  apiAddress: 'http://soerindicators.apiary.io'

  resultUrl: ->
    "#{@apiAddress}/indicators/#{@get('id')}/query?where=objectid+>+0&returnGeometry=false&outFields=#{@requiredFields().join()}&f=pjson"

  requiredFields: ->
    return @get('axes').x.fields

  getResults: (successCallback) ->
    $.ajax(
      url: @resultUrl()
    ).done((data)=>
      @results = data
      @trigger('resultsSync')
      successCallback() if successCallback?
    ).fail(->
      console.log "Couldn't get indicator results"
    )

  getXAxisField: ->
    return @get('axes').x.fields[0]

  getYAxisField: ->
    return @get('axes').y.fields[0]
