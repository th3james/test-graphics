(function(){var a=Handlebars.template,b=Handlebars.templates=Handlebars.templates||{};b["indicator_graphic.hbs"]=a(function(a,b,c,d,e){this.compilerInfo=[2,">= 1.0.0-rc.3"],c=c||a.helpers,e=e||{};var f="",g,h="function",i=this.escapeExpression;return f+="<h1>",(g=c.name)?g=g.call(b,{hash:{},data:e}):(g=b.name,g=typeof g===h?g.apply(b):g),f+=i(g)+'</h1>\n<div id="container"></div>\n',f}),b["maps.hbs"]=a(function(a,b,c,d,e){this.compilerInfo=[2,">= 1.0.0-rc.3"],c=c||a.helpers,e=e||{};var f="",g,h,i=c.helperMissing,j=this.escapeExpression;return f+="<h1>Maps</h1>\n",h={hash:{model:b.model},data:e},f+=j((g=c.subView,g?g.call(b,"MapView",h):i.call(b,"subView","MapView",h)))+"\n",f}),b["map.hbs"]=a(function(a,b,c,d,e){this.compilerInfo=[2,">= 1.0.0-rc.3"],c=c||a.helpers,e=e||{};var f="",g,h="function",i=this.escapeExpression;return f+="<h1>",(g=c.name)?g=g.call(b,{hash:{},data:e}):(g=b.name,g=typeof g===h?g.apply(b):g),f+=i(g)+"</h1>\n",f}),b["main_graphics.hbs"]=a(function(a,b,c,d,e){this.compilerInfo=[2,">= 1.0.0-rc.3"],c=c||a.helpers,e=e||{};var f="",g,h,i=c.helperMissing,j=this.escapeExpression;return f+="<h1>Graphics View</h1>\n<a href='#' id=\"switch-to-maps\">Switch to map layer indicators</a>\n",h={hash:{indicatorName:"recycling_rates"},data:e},f+=j((g=c.subView,g?g.call(b,"StackedColumnView",h):i.call(b,"subView","StackedColumnView",h)))+"\n",h={hash:{indicatorName:"waste_by_sector"},data:e},f+=j((g=c.subView,g?g.call(b,"PieChartView",h):i.call(b,"subView","PieChartView",h)))+"\n",h={hash:{indicatorName:"waste_by_sector"},data:e},f+=j((g=c.subView,g?g.call(b,"StackedColumnView",h):i.call(b,"subView","StackedColumnView",h)))+"\n",f})})()

;
// Generated by CoffeeScript 1.6.2
(function() {
  var _base, _base1, _base2, _base3, _base4, _base5, _base6, _base7, _base8, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  (_base = window.Backbone).Models || (_base.Models = {});

  window.Backbone.Models.Indicator = (function(_super) {
    __extends(Indicator, _super);

    function Indicator() {
      _ref = Indicator.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Indicator.prototype.defaults = {
      name: '',
      metadata: null,
      data: null
    };

    Indicator.prototype.fetchAllData = function(successCallback) {
      var _this = this;

      return this.getMetadata(function(metadata) {
        _this.set('metadata', metadata);
        return _this.getData(function(data) {
          _this.set('data', data);
          return successCallback();
        });
      });
    };

    Indicator.prototype.getMetadata = function(successCallback) {
      return $.ajax({
        url: "json/indicators/" + (this.get('name')) + "/metadata.json"
      }).done(successCallback).fail(function(a, b, c) {
        return console.log("Error getting metdata!");
      });
    };

    Indicator.prototype.getData = function(successCallback) {
      return $.ajax({
        url: "json/indicators/" + (this.get('name')) + ".json"
      }).done(successCallback);
    };

    Indicator.prototype.getFullTitle = function() {
      return "" + (this.get('metadata')['full name']) + " (" + (this.get('metadata')["date published"]) + ")";
    };

    Indicator.prototype.getXAxisField = function() {
      return this.get('metadata').axes.x.fields[0];
    };

    Indicator.prototype.getYAxisField = function() {
      return this.get('metadata').axes.y.fields[0];
    };

    return Indicator;

  })(Backbone.Model);

  (_base1 = window.Backbone).Models || (_base1.Models = {});

  window.Backbone.Models.MapIndicator = (function(_super) {
    __extends(MapIndicator, _super);

    function MapIndicator() {
      _ref1 = MapIndicator.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    MapIndicator.prototype.initialize = function(options) {
      this.serviceName = options.serviceName;
      return this.layer = options.layer;
    };

    MapIndicator.prototype.getMetadata = function(successCallback) {
      return $.ajax({
        url: "json/map_indicators/" + (this.get('serviceName')) + "/MapServer/" + (this.get('layer')) + ".json"
      }).done(successCallback).fail(function(a, b, c) {
        return console.log("Error getting metdata!");
      });
    };

    MapIndicator.prototype.getData = function(successCallback) {
      return $.ajax({
        url: "json/map_indicators/" + (this.get('serviceName')) + "/MapServer/" + (this.get('layer')) + "/find.json"
      }).done(successCallback);
    };

    return MapIndicator;

  })(Backbone.Models.Indicator);

  window.Backbone || (window.Backbone = {});

  (_base2 = window.Backbone).Views || (_base2.Views = {});

  Backbone.Views.IndicatorGraphicView = (function(_super) {
    __extends(IndicatorGraphicView, _super);

    function IndicatorGraphicView() {
      this.render = __bind(this.render, this);      _ref2 = IndicatorGraphicView.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    IndicatorGraphicView.prototype.template = Handlebars.templates['indicator_graphic.hbs'];

    IndicatorGraphicView.prototype.initialize = function(options) {
      this.indicator = new Backbone.Models.Indicator({
        name: options.indicatorName
      });
      return this.indicator.fetchAllData(this.render);
    };

    IndicatorGraphicView.prototype.render = function() {
      this.$el.html(this.template({
        name: this.indicator.get('name')
      }));
      this.drawGraph();
      return this;
    };

    IndicatorGraphicView.prototype.onClose = function() {};

    return IndicatorGraphicView;

  })(Backbone.View);

  window.Backbone || (window.Backbone = {});

  (_base3 = window.Backbone).Views || (_base3.Views = {});

  Backbone.Views.StackedColumnView = (function(_super) {
    __extends(StackedColumnView, _super);

    function StackedColumnView() {
      _ref3 = StackedColumnView.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    StackedColumnView.prototype.getCategoriesFromIndicator = function() {
      var categories, entry, xAxisField, _i, _len, _ref4;

      xAxisField = this.indicator.getXAxisField();
      categories = [];
      _ref4 = this.indicator.get('data');
      for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
        entry = _ref4[_i];
        categories.push(entry[xAxisField]);
      }
      return categories;
    };

    StackedColumnView.prototype.getSeriesFromIndicator = function() {
      var entry, fieldName, group, series, xAxisField, _i, _j, _len, _len1, _ref4, _ref5;

      xAxisField = this.indicator.getXAxisField();
      series = [];
      _ref4 = this.indicator.get('metadata').axes.y.fields;
      for (_i = 0, _len = _ref4.length; _i < _len; _i++) {
        fieldName = _ref4[_i];
        group = {
          name: fieldName,
          data: []
        };
        _ref5 = this.indicator.get('data');
        for (_j = 0, _len1 = _ref5.length; _j < _len1; _j++) {
          entry = _ref5[_j];
          group.data.push(entry[fieldName]);
        }
        series.push(group);
      }
      return series;
    };

    StackedColumnView.prototype.drawGraph = function() {
      if (this.indicator.get('metadata') == null) {
        return;
      }
      return this.$el.find("#container").highcharts({
        chart: {
          type: "column"
        },
        title: {
          text: this.indicator.getFullTitle()
        },
        xAxis: {
          categories: this.getCategoriesFromIndicator(),
          title: {
            text: this.indicator.get('metadata').axes.x.name
          }
        },
        yAxis: {
          min: 0,
          title: {
            text: this.indicator.get('metadata').axes.y.name
          },
          stackLabels: {
            enabled: true,
            style: {
              fontWeight: "bold",
              color: (Highcharts.theme && Highcharts.theme.textColor) || "gray"
            }
          }
        },
        legend: {
          align: "right",
          x: -100,
          verticalAlign: "top",
          y: 20,
          floating: true,
          backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || "white",
          borderColor: "#CCC",
          borderWidth: 1,
          shadow: false
        },
        tooltip: {
          formatter: function() {
            return "<b>" + this.x + "</b><br/>" + this.series.name + ": " + this.y + "<br/>" + "Total: " + this.point.stackTotal;
          }
        },
        plotOptions: {
          column: {
            stacking: "normal",
            dataLabels: {
              enabled: true,
              color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || "white"
            }
          }
        },
        series: this.getSeriesFromIndicator()
      });
    };

    return StackedColumnView;

  })(Backbone.Views.IndicatorGraphicView);

  window.Backbone || (window.Backbone = {});

  (_base4 = window.Backbone).Views || (_base4.Views = {});

  Backbone.Views.PieChartView = (function(_super) {
    __extends(PieChartView, _super);

    function PieChartView() {
      _ref4 = PieChartView.__super__.constructor.apply(this, arguments);
      return _ref4;
    }

    PieChartView.prototype.getSeriesFromIndicator = function() {
      var entry, series, xAxisField, yAxisField, _i, _len, _ref5;

      xAxisField = this.indicator.getXAxisField();
      yAxisField = this.indicator.getYAxisField();
      series = [];
      _ref5 = this.indicator.get('data');
      for (_i = 0, _len = _ref5.length; _i < _len; _i++) {
        entry = _ref5[_i];
        series.push([entry[xAxisField], entry[yAxisField]]);
      }
      return series;
    };

    PieChartView.prototype.drawGraph = function() {
      var xAxisField;

      if (this.indicator.get('metadata') == null) {
        return;
      }
      xAxisField = this.indicator.getXAxisField();
      return this.$el.find("#container").highcharts({
        chart: {
          plotBackgroundColor: null,
          plotBorderWidth: null,
          plotShadow: false
        },
        title: {
          text: this.indicator.getFullTitle()
        },
        tooltip: {
          pointFormat: "{series.name}: <b>{point.percentage}%</b>",
          percentageDecimals: 1
        },
        plotOptions: {
          pie: {
            allowPointSelect: true,
            cursor: "pointer",
            dataLabels: {
              enabled: true,
              color: "#000000",
              connectorColor: "#000000",
              formatter: function() {
                var name;

                name = this.point.name === 'Slice' ? this.point.x : this.point.name;
                return "<b>" + name + "</b>: " + this.percentage + " %";
              }
            }
          }
        },
        series: [
          {
            type: "pie",
            name: this.indicator.get('metadata')['full name'],
            data: this.getSeriesFromIndicator()
          }
        ]
      });
    };

    return PieChartView;

  })(Backbone.Views.IndicatorGraphicView);

  window.Backbone || (window.Backbone = {});

  (_base5 = window.Backbone).Views || (_base5.Views = {});

  Backbone.Views.MapsView = (function(_super) {
    __extends(MapsView, _super);

    function MapsView() {
      this.render = __bind(this.render, this);      _ref5 = MapsView.__super__.constructor.apply(this, arguments);
      return _ref5;
    }

    MapsView.prototype.template = Handlebars.templates['maps.hbs'];

    MapsView.prototype.initialize = function(options) {
      return this.mapIndicator = new Backbone.Models.MapIndicator({
        serviceName: "ESRI_StateCityHighway_USA",
        layer: 1
      });
    };

    MapsView.prototype.render = function() {
      this.closeSubViews();
      this.$el.html(this.template({
        model: this.mapIndicator
      }));
      this.renderSubViews();
      return this;
    };

    MapsView.prototype.onClose = function() {
      return this.closeSubViews();
    };

    return MapsView;

  })(Backbone.Diorama.NestingView);

  window.Backbone || (window.Backbone = {});

  (_base6 = window.Backbone).Views || (_base6.Views = {});

  Backbone.Views.MapView = (function(_super) {
    __extends(MapView, _super);

    function MapView() {
      this.render = __bind(this.render, this);      _ref6 = MapView.__super__.constructor.apply(this, arguments);
      return _ref6;
    }

    MapView.prototype.template = Handlebars.templates['map.hbs'];

    MapView.prototype.initialize = function(options) {
      this.mapIndicator = options.model;
      return this.mapIndicator.fetchAllData(this.render);
    };

    MapView.prototype.render = function() {
      debugger;      if (this.mapIndicator.get('metadata') != null) {
        this.$el.html(this.template({
          name: this.mapIndicator.get('metadata').name
        }));
      }
      return this;
    };

    MapView.prototype.onClose = function() {};

    return MapView;

  })(Backbone.View);

  window.Backbone || (window.Backbone = {});

  (_base7 = window.Backbone).Controllers || (_base7.Controllers = {});

  Backbone.Controllers.MainController = (function(_super) {
    __extends(MainController, _super);

    function MainController() {
      this.maps = __bind(this.maps, this);
      this.graphics = __bind(this.graphics, this);      this.mainRegion = new Backbone.Diorama.ManagedRegion();
      $('body').append(this.mainRegion.$el);
      this.graphics();
    }

    MainController.prototype.graphics = function() {
      var graphicsView;

      graphicsView = new Backbone.Views.MainGraphicsView();
      this.mainRegion.showView(graphicsView);
      /*
        @changeStateOn maps events published by other objects to
        controller states
      */

      return this.changeStateOn({
        event: 'switchToMaps',
        publisher: graphicsView,
        newState: this.maps
      });
    };

    MainController.prototype.maps = function() {
      var mapsView;

      mapsView = new Backbone.Views.MapsView();
      this.mainRegion.showView(mapsView);
      /*
        @changeStateOn maps events published by other objects to
        controller states
      */

      return this.changeStateOn({
        event: 'switchToGraphics',
        publisher: mapsView,
        newState: this.graphics
      });
    };

    return MainController;

  })(Backbone.Diorama.Controller);

  window.Backbone || (window.Backbone = {});

  (_base8 = window.Backbone).Views || (_base8.Views = {});

  Backbone.Views.MainGraphicsView = (function(_super) {
    __extends(MainGraphicsView, _super);

    function MainGraphicsView() {
      _ref7 = MainGraphicsView.__super__.constructor.apply(this, arguments);
      return _ref7;
    }

    MainGraphicsView.prototype.template = Handlebars.templates['main_graphics.hbs'];

    MainGraphicsView.prototype.events = {
      "click #switch-to-maps": "triggerSwitchToMaps"
    };

    MainGraphicsView.prototype.initialize = function(options) {
      return this.render();
    };

    MainGraphicsView.prototype.render = function() {
      this.closeSubViews();
      this.$el.html(this.template());
      this.renderSubViews();
      return this;
    };

    MainGraphicsView.prototype.triggerSwitchToMaps = function() {
      return this.trigger('switchToMaps');
    };

    MainGraphicsView.prototype.onClose = function() {
      return this.closeSubViews();
    };

    return MainGraphicsView;

  })(Backbone.Diorama.NestingView);

}).call(this);
