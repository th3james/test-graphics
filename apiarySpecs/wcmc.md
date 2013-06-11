ST: http://www.google.com/

--- WCMC Indicator API ---

---
API developed by WCMC, hosted at EAD
---

--
Indicator Resources
--

List of indicators. Data in here is based on the metadata from the K&A ESRI API
GET /indicators
< 200
< Content-Type: application/json
{ "indicators": [
    { 
        "id": 0,
        "name": "US Road length",
        "axes": {
            "x": {
              "fields": ["TYPE"]
            },
            "y": {
              "fields": ["LENGTH"]
            }
        } 
    },
] }

