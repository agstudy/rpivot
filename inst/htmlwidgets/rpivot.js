
HTMLWidgets.widget({

  name: "rpivot",
  type: "output",

  initialize: function(el, width, height) {
    return {
      width: width,
      height: height
    }
  },

  renderValue: function(el, x, instanceData) {

    var pgridwidget = window.orb.instances[x.name],
        config = x.config;

    config.name = x.name;
    config.dataSource = x.dataSource;

    if(instanceData != null) {
      config.width = instanceData.width;
      config.height = instanceData.height;
    }

    if(pgridwidget != null) {
      pgridwidget.rebuild(config);
    } else {
      // Render it inside a container element:
      pgridwidget = new orb.pgridwidget(config);
      pgridwidget.render(el);
    }

  },

  resize: function(el, width, height, instance) {
    var pgridwidget = window.orb.instances.findByDOMElement(el),
        config;

    if(pgridwidget != null) {
      config = pgridwidget.getCurrentConfig();
      config.width = width;
      config.height = height;
      pgridwidget.rebuild(config);
    }
  }
});
