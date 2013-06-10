HOST: http://www.google.com/

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
        "name": "Protected Area cover",
        "axes": {
            "x": {
              "fields": ["Protected Area %"],
              "unit": "percentage",
              "name": "State name",
              "fields": ["PA_cover"]
            }
        } 
    }
] }

