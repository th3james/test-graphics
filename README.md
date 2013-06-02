# Graphics test

Playing around with what an api might need to look like to power different graphics.

## ESRI Example layers

I'm using the esri example layers as the basic for my JSON examples, which I've
put in json/map_indicators/
The example service I'm is: http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Specialty/ESRI_StateCityHighway_USA/MapServer?f=pjson

To make automatic graphic generation work, I had to add the 'axes' section to the layer metadata, in [the layer json](json/map_indicators/ESRI_StateCityHighway_USA/MapServer/1.json):

```json 
  "axes": {
    "x": {
      "fields": ["STATE_NAME"],
      "unit": "text",
      "name": "State name"
    },
    "y": {
      "fields": ["AREA"],
      "name": "Area",
      "unit": "KM<sup>2</sup>"
    }
  }
```

In theory, it would be fairly easy to generate config like this if this information was not available in the API, using a simple UI where the user picks the axes
