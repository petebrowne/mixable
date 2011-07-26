# When copying properties, skip over the following:
SKIP_PROPERTIES = [
  "constructor"
  "extended"
  "included"
  "prototype"
]

# Adds each property from the mixin to the given object.
__extend = (object, mixin) ->
  for own name, method of mixin when name not in SKIP_PROPERTIES
    object[name] = method
    
# Adds the instance methods from each given mixin
# as class methods.
extend = (object, mixins...) ->
  for mixin in mixins
    __extend object, mixin:: ? mixin
    mixin.extended object if mixin.extended?
    
# Adds the instance and class methods from each
# given mixin.
include = (object, mixins...) ->
  throw new TypeError unless object::?
  for mixin in mixins
    if mixin::?
      __extend object, mixin
      __extend object::, mixin::
    else
      __extend object::, mixin
    mixin.included object if mixin.included?

# Base class for adding mixins, Ruby style, to CoffeeScript
# classes. There is no support for super. This essentially
# just copies over properties from objects and classes.
class Mixable
  # Calls extend method, with `this` as the object.
  @extend: (mixins...) ->
    extend @, mixins...

  # Calls include method, with `this` as the object.
  @include: (mixins...) ->
    include @, mixins...
      
# Expose the public API
root         = exports ? window
root.extend  = extend
root.include = include
root.Mixable = Mixable
  