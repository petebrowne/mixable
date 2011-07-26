Mixable.coffee
==============

_A Ruby style mixin library for CoffeeScript & Javascript_

Basic Usage
-----------

Mixable is a simple class that includes two class methods familiar to Rubyists: `extend` & `include`. To use Mixable, inherit from it like any other class in CoffeeScript. In the class body you can call `extend` to add class methods and `include` to add instance methods:

```coffee-script
ClassMethods =
  classMethod: -> "a class method!"
  
InstanceMethods =
  instanceMethod: -> "an instance method!"
  
class Foo extends Mixable
  @extend  ClassMethods
  @include InstanceMethods
  
Foo.classMethod()          # => "a class method!"
new Foo().instanceMethod() # => "an instance method!"
```

_Note: There is no support for `super` or method lookups. Mixable essentially just copies over properties from one object to another. If you need support for method lookups, look at [Classify](http://classify.petebrowne.com)._

extend
------

`extend(object, mixins...)`

Adds the properties of each given mixin to the given object.

```coffee-script
Mixin =
  method: -> "a method!"
  
foo = {}
extend foo, Mixin
foo.method() # => "a method!"
```

This can be used within a class body when you cannot extend the Mixable class.

```coffee-script
Mixin =
  method: -> "a class method!"
  
class Foo
  extend @, Mixin
  
Foo.method() # => "a class method!"
```

If a class is given, its instance properties will be used, (__not its class properties__). This mimics the behavior of Ruby's mixin system.

```coffee-script
class Mixin
  @classMethod: -> "a class method!"
  instanceMethod: -> "an instance method!"
  
class Foo
  extend @, Mixin
  
Foo.classMethod()    # => TypeError: Foo has no method 'classMethod'
Foo.instanceMethod() # => "an instance method!"
```

---

`Mixable.extend(mixins...)`

Adds the properties of each given mixin as class properties. Essentially a shortcut for `extend @, mixins...`.

```coffee-script
Mixin =
  method: -> "a class method!"
  
class Foo extends Mixable
  @extend Mixin
  
Foo.method() # => "a class method!"
```

include
-------

`include(object, mixins...)`

Adds the properties of each given mixin as instance properties. This assumes the `object` is actually a class, and will throw a `TypeError` if it does not have a protoype.

```coffee-script
Mixin =
  method: -> "an instance method!"
  
class Foo
  include @, Mixin
  
new Foo().method() # => "an instance method!"
```

If a class is given, its instance properties will be added as instance properties and its class properties will also be added as class properties. Essentially, all of its properties are added. _Note: This is very different from how Ruby's mixin system works._

```coffee-script
class Mixin
  @classMethod: -> "a class method!"
  instanceMethod: -> "an instance method!"
  
class Foo
  include @, Mixin
  
Foo.classMethod()          # => "a class method!"
new Foo().instanceMethod() # => "an instance method!"
```

---

`Mixable.include(mixins...)`

Adds the properties of each given mixin as instance properties. Essentially a shortcut for `include @, mixins...`.

```coffee-script
Mixin =
  method: -> "an instance method!"
  
class Foo extends Mixable
  @include Mixin
  
new Foo().method() # => "an instance method!"
```

---

Copyright (c) 2011 [Pete Browne](http://petebrowne.com). See LICENSE for details.
