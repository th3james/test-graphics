ST: http://www.google.com/

--- K&A ESRI Indicator ReST API.

---
This is the spec for the K&A developed ReST API for indicators. It provides metadata about each indicator, which is used to 
configure the indicator setup for the WCMC-developed server component, and the access to the actual indicator data 
---

Standard ESRI output for a layer. We'll use this route to determine our configuration for visualising the data,
and also to work out which fields we need to ask for in indicator/0/query.
GET /indicators/0?f=pjson
< 200
< Content-Type: application/json
{
  "currentVersion" : 10.01, 
  "id" : 0, 
  "name" : "ushigh", 
  "type" : "Feature Layer", 
  "description" : "This service provides census information for U.S. cities and states including total population, racial counts, and more. It also includes highways. \n", 
  "definitionExpression" : "", 
  "geometryType" : "esriGeometryPolyline", 
  "copyrightText" : "(c) ESRI and its data partners", 
  "parentLayer" : null, 
  "subLayers" : [], 
  "minScale" : 0, 
  "maxScale" : 0, 
  "defaultVisibility" : true, 
  "extent" : {
    "xmin" : -158.204086303711, 
    "ymin" : 19.0670623779298, 
    "xmax" : -67.0972431225637, 
    "ymax" : 70.3192330240338, 
    "spatialReference" : {
      "wkid" : 4326
    }
  }, 
  "hasAttachments" : false, 
  "htmlPopupType" : "esriServerHTMLPopupTypeNone", 
  "drawingInfo" : {"renderer" : 
    {
      "type" : "simple", 
      "symbol" : 
      {
        "type" : "esriSLS", 
        "style" : "esriSLSSolid",
        "color" : [
          250, 
          52, 
          17, 
          255
        ], 
        "width" : 1.7
      }, 
      "label" : "", 
      "description" : ""
    }, 
    "transparency" : 0, 
    "labelingInfo" : null}, 
  "displayField" : "TYPE", 
  "fields" : [
    {
      "name" : "OBJECTID", 
      "type" : "esriFieldTypeOID", 
      "alias" : "OBJECTID"}, 
    {
      "name" : "Shape", 
      "type" : "esriFieldTypeGeometry", 
      "alias" : "Shape"}, 
    {
      "name" : "LENGTH", 
      "type" : "esriFieldTypeDouble", 
      "alias" : "LENGTH"}, 
    {
      "name" : "TYPE", 
      "type" : "esriFieldTypeString", 
      "alias" : "TYPE", 
      "length" : 40}, 
    {
      "name" : "ADMN_CLASS", 
      "type" : "esriFieldTypeString", 
      "alias" : "ADMN_CLASS", 
      "length" : 20}, 
    {
      "name" : "TOLL_RD", 
      "type" : "esriFieldTypeString", 
      "alias" : "TOLL_RD", 
      "length" : 1}, 
    {
      "name" : "RTE_NUM1", 
      "type" : "esriFieldTypeString", 
      "alias" : "RTE_NUM1", 
      "length" : 3}, 
    {
      "name" : "RTE_NUM2", 
      "type" : "esriFieldTypeString", 
      "alias" : "RTE_NUM2", 
      "length" : 3}, 
    {
      "name" : "ROUTE", 
      "type" : "esriFieldTypeString", 
      "alias" : "ROUTE", 
      "length" : 40}, 
    {
      "name" : "Shape_Length", 
      "type" : "esriFieldTypeDouble", 
      "alias" : "Shape_Length"}
  ], 
  "typeIdField" : null, 
  "types" : null, 
  "relationships" : [], 
  "capabilities" : "Map,Query,Data"
}

Get indicator data. The outFields parameter will be set based on the metadata route above.
There doesn't appear to be a way to send the request without a 'where' clause, so ours is
meaningless ('id>0')
GET /indicators/0/query?where=objectid+>+0&returnGeometry=false&outFields=LENGTH,TYPE&f=pjson
< 200
< Content-Type: application/json
{
  "displayFieldName" : "TYPE",
  "fieldAliases" : {
    "LENGTH" : "LENGTH",
    "TYPE" : "TYPE"
  },
  "fields" : [
    {
      "name" : "LENGTH",
      "type" : "esriFieldTypeDouble",
      "alias" : "LENGTH"
    },
    {
      "name" : "TYPE",
      "type" : "esriFieldTypeString",
      "alias" : "TYPE",
      "length" : 40
    }
  ],
  "features" : [
    {
      "attributes" : {
        "LENGTH" : 140.93100000000001,
        "TYPE" : "Multi-Lane Divided"
      }
    },
    {
      "attributes" : {
        "LENGTH" : 186.06,
        "TYPE" : "Multi-Lane Divided"
      }
    },
    {
      "attributes" : {
        "LENGTH" : 50.12,
        "TYPE" : "Single Lane"
      }
    }
  ]
}

