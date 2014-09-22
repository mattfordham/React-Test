(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var DOM, tag, tagName, _fn,
  __slice = [].slice;

DOM = React.DOM;

_fn = (function(_this) {
  return function(tagName) {
    return module.exports[tagName] = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return tag.apply(null, [tagName].concat(__slice.call(args)));
    };
  };
})(this);
for (tagName in DOM) {
  _fn(tagName);
}

tag = function() {
  var args, attributes, name, _ref;
  name = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
  if (((_ref = args[0]) != null ? _ref.constructor : void 0) === Object) {
    attributes = args.shift();
  } else {
    attributes = {};
  }
  if (attributes.hasOwnProperty('class')) {
    attributes.className = attributes["class"];
    delete attributes["class"];
  }
  return DOM[name].apply(DOM, [attributes].concat(__slice.call(args)));
};


},{}],2:[function(require,module,exports){
var DOM, Inner, List, Outer, a, div, h1, h2, input, li, ul;

DOM = require("./DOM.coffee");

div = DOM.div, h1 = DOM.h1, ul = DOM.ul, li = DOM.li, h2 = DOM.h2, input = DOM.input, a = DOM.a;

Outer = React.createClass({
  getInitialState: function() {
    var state;
    state = {
      secondsElapsed: 0,
      name: this.props.name
    };
    return state;
  },
  tick: function() {
    return this.setState({
      secondsElapsed: this.state.secondsElapsed + 1
    });
  },
  onChange: function(e) {
    return this.setState({
      name: e.target.value
    });
  },
  componentDidMount: function() {
    return this.interval = setInterval(this.tick, 1000);
  },
  render: function() {
    return div({
      className: "outer"
    }, h1({
      ref: "header"
    }, "Hey " + this.state.name + " / " + this.state.secondsElapsed), input({
      type: "text",
      name: "name",
      onChange: this.onChange
    }), ul({}, li({}, "One " + this.state.secondsElapsed), li({}, "Two " + this.state.secondsElapsed), li({}, "Three " + this.state.secondsElapsed)), Inner({
      name: this.state.name,
      secondsElapsed: this.state.secondsElapsed
    }));
  }
});

Inner = React.createClass({
  render: function() {
    return div({
      className: "inner"
    }, h2({}, "Name - " + this.props.name), a({
      href: "http://www.google.com",
      target: "_blank"
    }, "Link!"), List({
      secondsElapsed: this.props.secondsElapsed
    }));
  }
});

List = React.createClass({
  render: function() {
    return ul({}, li({}, "one " + this.props.secondsElapsed), li({}, "two " + this.props.secondsElapsed), li({}, "three " + this.props.secondsElapsed));
  }
});

$(function() {
  return React.renderComponent(Outer({
    name: "there"
  }), $("#content")[0]);
});


},{"./DOM.coffee":1}]},{},[2])