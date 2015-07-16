function recycle(values, length, inPlace) {
  if (length === 0 && !inPlace)
    return [];

  if (!(values instanceof Array)) {
    if (inPlace) {
      throw new Error("Can't do in-place recycling of a non-Array value");
    }
    values = [values];
  }
  if (typeof(length) === 'undefined')
    length = values.length;

  var dest = inPlace ? values : [];
  var origLength = values.length;
  while (dest.length < length) {
    dest.push(values[dest.length % origLength]);
  }
  if (dest.length > length) {
    dest.splice(length, dest.length - length);
  }
  return dest;
}

function asArray(value) {
  if (value instanceof Array)
    return value;
  else
    return [value];
}

var dataframe = (function() {
  var exports = {};

  var DataFrame = function() {
    this.columns = [];
    this.colnames = [];
    this.colstrict = [];

    this.effectiveLength = 0;
    this.colindices = {};
  };

  DataFrame.prototype._updateCachedProperties = function() {
    var self = this;
    this.effectiveLength = 0;
    this.colindices = {};

    $.each(this.columns, function(i, column) {
      self.effectiveLength = Math.max(self.effectiveLength, column.length);
      self.colindices[self.colnames[i]] = i;
    });
  };

  DataFrame.prototype._colIndex = function(colname) {
    var index = this.colindices[colname];
    if (typeof(index) === 'undefined')
      return -1;
    return index;
  };

  DataFrame.prototype.col = function(name, values, strict) {
    if (typeof(name) !== 'string')
      throw new Error('Invalid column name "' + name + '"');

    var index = this._colIndex(name);

    if (arguments.length === 1) {
      if (index < 0)
        return null;
      else
        return recycle(this.columns[index], this.effectiveLength);
    }

    if (index < 0) {
      index = this.colnames.length;
      this.colnames.push(name);
    }
    this.columns[index] = asArray(values);
    this.colstrict[index] = !!strict;

    // TODO: Validate strictness (ensure lengths match up with other stricts)

    this._updateCachedProperties();

    return this;
  };

  DataFrame.prototype.cbind = function(obj, strict) {
    var self = this, name;
    $.each(obj, function(name, coldata) {
      self.col(name, coldata);
    });
    return this;
  };

  DataFrame.prototype.get = function(row, col) {
    var self = this;

    if (row > this.effectiveLength)
      throw new Error('Row argument was out of bounds: ' + row + ' > ' + this.effectiveLength);

    var colIndex = -1;
    if (typeof(col) === 'undefined') {
      var rowData = {};
      $.each(this.colnames, function(i, name) {
        rowData[name] = self.columns[i][row % self.columns[i].length];
      });
      return rowData;
    } else if (typeof(col) === 'string') {
      colIndex = this._colIndex(col);
    } else if (typeof(col) === 'number') {
      colIndex = col;
    }
    if (colIndex < 0 || colIndex > this.columns.length)
      throw new Error('Unknown column index: ' + col);

    return this.columns[colIndex][row % this.columns[colIndex].length];
  };

  DataFrame.prototype.nrow = function() {
    return this.effectiveLength;
  };

  function test() {
    var df = new DataFrame();
    df.col("speed", [4, 4, 7, 7, 8, 9, 10, 10, 10, 11, 11, 12, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 16, 16, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 20, 20, 20, 20, 20, 22, 23, 24, 24, 24, 24, 25])
      .col("dist", [2, 10, 4, 22, 16, 10, 18, 26, 34, 17, 28, 14, 20, 24, 28, 26, 34, 34, 46, 26, 36, 60, 80, 20, 26, 54, 32, 40, 32, 40, 50, 42, 56, 76, 84, 36, 46, 68, 32, 48, 52, 56, 64, 66, 54, 70, 92, 93, 120, 85])
      .col("color", ["yellow", "red"])
      .cbind({
        "Make" : ["Toyota", "Cadillac", "BMW"],
        "Model" : ["Corolla", "CTS", "435i"]
      })
    ;
    console.log(df.get(9, "speed"));
    console.log(df.get(9, "dist"));
    console.log(df.get(9, "color"));
    console.log(df.get(9, "Make"));
    console.log(df.get(9, "Model"));
    console.log(df.get(9));

  }

  return {
    create: function() {
      return new DataFrame();
    }
  };

})();


HTMLWidgets.widget({

  name: "rpivot",
  type: "output",

  initialize: function(el, width, height) {


  },

  renderValue: function(el, x, instance) {

    var config = {
      dataSource: x.data,
      fields : x.config.fields
    };

    var pgridw = new orb.pgridwidget(config);
    // Render it inside a container element:
    pgridw.render(el);

  },

  resize: function(el, width, height, instance) {


  }
});
