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
    ).done(successCallback)

  getData: (successCallback) ->
    $.ajax(
      url: "json/indicators/#{@get('name')}.json"
    ).done(successCallback)

  getXAxisField: ->
    @get('metadata').axes.x.field

  getCategories: ->
    xAxisField = @getXAxisField()

    categories = []
    for entry in @get('data')
      categories.push(entry[xAxisField])
    return categories

  getSeries: ->
    xAxisField = @getXAxisField()

    series = []

    if @get('data').length > 0
      for fieldName, value of @get('data')[0]
        if fieldName != xAxisField
          group = {name: fieldName, data: []}
          for entry in @get('data')
            group.data.push entry[fieldName]
          series.push group
    
    return series
