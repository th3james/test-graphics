# SOER API test front-end

This app is designed as a test consumer for the indicator APIs which will be used in the
SOER project. It depends on 2 JSON APIs:

[http://docs.soerindicators.apiary.io/](http://docs.soerindicators.apiary.io/)
ESRI based indicator data api

[http://docs.wcmcindicatorapi.apiary.io/](http://docs.wcmcindicatorapi.apiary.io/)
'App' API, which provides an index of indicators for the application to use. Essentially,
this repackages the metadata from the above API, adding configuration for this app.

## Apiary specs
The apiary specs (which are used to power the apiary APIs this app communicates with) are backed up in the apiarySpecs folder
