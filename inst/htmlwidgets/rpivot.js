
HTMLWidgets.widget({

  name: "rpivot",
  type: "output",

  initialize: function(el, width, height) {


  },

  renderValue: function(el, x, instance) {

    var config = x.config;
    config.dataSource = x.dataSource;

    window.pgridwidget = new orb.pgridwidget(config);
    // Render it inside a container element:
    pgridwidget.render(el);

  },

  resize: function(el, width, height, instance) {


  }
});
