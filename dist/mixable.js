/**
 * Modular.js v0.1.1
 * http://github.com/petebrowne/mixable
 * 
 * Copyright (c) 2011, Pete Browne
 * See LICENSE for details
 */
(function() {
  var Mixable, SKIP_PROPERTIES, extend, include, root, __extend;
  var __hasProp = Object.prototype.hasOwnProperty, __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  }, __slice = Array.prototype.slice;
  SKIP_PROPERTIES = ["constructor", "extended", "included", "prototype"];
  __extend = function(object, mixin) {
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
  extend = function() {
    var mixin, mixins, object, _i, _len, _ref, _results;
    object = arguments[0], mixins = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    _results = [];
    for (_i = 0, _len = mixins.length; _i < _len; _i++) {
      mixin = mixins[_i];
      __extend(object, (_ref = mixin.prototype) != null ? _ref : mixin);
      _results.push(mixin.extended != null ? mixin.extended(object) : void 0);
    }
    return _results;
  };
  include = function() {
    var mixin, mixins, object, _i, _len, _results;
    object = arguments[0], mixins = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    if (object.prototype == null) {
      throw new TypeError;
    }
    _results = [];
    for (_i = 0, _len = mixins.length; _i < _len; _i++) {
      mixin = mixins[_i];
      if (mixin.prototype != null) {
        __extend(object, mixin);
        __extend(object.prototype, mixin.prototype);
      } else {
        __extend(object.prototype, mixin);
      }
      _results.push(mixin.included != null ? mixin.included(object) : void 0);
    }
    return _results;
  };
  Mixable = (function() {
    function Mixable() {}
    Mixable.extend = function() {
      var mixins;
      mixins = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return extend.apply(null, [this].concat(__slice.call(mixins)));
    };
    Mixable.include = function() {
      var mixins;
      mixins = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return include.apply(null, [this].concat(__slice.call(mixins)));
    };
    return Mixable;
  })();
  root = typeof exports !== "undefined" && exports !== null ? exports : window;
  root.extend = extend;
  root.include = include;
  root.Mixable = Mixable;
}).call(this);
