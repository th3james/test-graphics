window.Backbone.Models || = {}

class window.Backbone.Models.ApiaryIndicator extends Backbone.Model
  apiAddress: 'http://soerindicators.apiary.io'

  resultUrl: ->
    "#{@apiAddress}/indicators/#{@get('id')}/query?where=objectid+>+0&returnGeometry=false&outFields=LENGTH,TYPE&f=pjson"
