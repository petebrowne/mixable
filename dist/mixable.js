/**
 * Modular.js v0.1.1
 * http://github.com/petebrowne/mixable
 * 
 * Copyright (c) 2011, Pete Browne
 * See LICENSE for details
 */
(function() {
  var Mixable, SKIP_PROPERTIES, extend, root;
  var __hasProp = Object.prototype.hasOwnProperty, __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  }, __slice = Array.prototype.slice;
  SKIP_PROPERTIES = ["constructor", "extended", "included", "prototype"];
  extend = function(object, mixin) {
    var method, name, _results;
    _results = [];
    for (name in mixin) {
      if (!__hasProp.call(mixin, name)) continue;
      method = mixin[name];
      if (__indexOf.call(SKIP_PROPERTIES, name) < 0) {
        _results.push(object[name] = method);
      }
    }
    return _results;
  };
  Mixable = (function() {
    function Mixable() {}
    Mixable.extend = function() {
      var mixin, mixins, _i, _len, _ref, _results;
      mixins = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      _results = [];
      for (_i = 0, _len = mixins.length; _i < _len; _i++) {
        mixin = mixins[_i];
        extend(this, (_ref = mixin.prototype) != null ? _ref : mixin);
        _results.push(mixin.extended != null ? mixin.extended(this) : void 0);
      }
      return _results;
    };
    Mixable.include = function() {
      var mixin, mixins, _i, _len, _results;
      mixins = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      _results = [];
      for (_i = 0, _len = mixins.length; _i < _len; _i++) {
        mixin = mixins[_i];
        if (mixin.prototype != null) {
          extend(this, mixin);
          extend(this.prototype, mixin.prototype);
        } else {
          extend(this.prototype, mixin);
        }
        _results.push(mixin.included != null ? mixin.included(this) : void 0);
      }
      return _results;
    };
    return Mixable;
  })();
  root = typeof exports !== "undefined" && exports !== null ? exports : window;
  root.extend = extend;
  root.Mixable = Mixable;
}).call(this);
