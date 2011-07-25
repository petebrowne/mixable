# When copying properties, skip over the following:
SKIP_PROPERTIES = [
  "constructor"
  "extended"
  "included"
  "prototype"
]

# Adds each property from the mixin to the given object.
extend = (object, mixin) ->
  for own name, method of mixin when name not in SKIP_PROPERTIES
    object[name] = method

# Base class for adding mixins, Ruby style, to CoffeeScript
# classes. There is no support for super. This essentially
# just copies over properties from objects and classes.
class Mixable
  
  # Adds the instance methods from each given mixin
  # as class methods.
  @extend: (mixins...) ->
    for mixin in mixins
      extend @, mixin:: ? mixin
      mixin.extended @ if mixin.extended?

  # Adds the instance and class methods from each
  # mixin given.
  @include: (mixins...) ->
    for mixin in mixins
      if mixin::?
        extend @, mixin
        extend @::, mixin::
      else
        extend @::, mixin
      mixin.included @ if mixin.included
      
# Expose the public API
root         = exports ? window
root.extend  = extend
root.Mixable = Mixable
  