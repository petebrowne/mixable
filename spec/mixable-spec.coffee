{ Mixable } = if require? then require "../dist/mixable" else window

describe "Mixable", ->
  describe ".extend", ->
    it "adds an object's methods as class methods", ->
      Foo =
        methodA: -> true
        methodB: -> false
        
      class Bar extends Mixable
        @extend Foo
        
      expect(Bar.methodA()).toBe true
      expect(Bar.methodB()).toBe false
  
    it "adds a mixin's instance methods as class methods", ->
      class Foo
        methodA: -> true
        methodB: -> false
        
      class Bar extends Mixable
        @extend Foo
        
      expect(Bar.methodA()).toBe true
      expect(Bar.methodB()).toBe false
      
    it "calls the mixin's .extended method", ->
      class Foo
        @extended: (base) ->
          @extendedBy = base
          
      class Bar extends Mixable
        @extend Foo
        
      expect(Foo.extendedBy).toBe Bar
       
  describe ".include", ->
    it "adds an object's methods as class methods", ->
      Foo =
        methodA: -> true
        methodB: -> false
        
      class Bar extends Mixable
        @include Foo
        
      expect(new Bar().methodA()).toBe true
      expect(new Bar().methodB()).toBe false
  
    it "adds a mixin's instance methods as instance methods", ->
      class Foo
        methodA: -> true
        methodB: -> false
        
      class Bar extends Mixable
        @include Foo
        
      expect(new Bar().methodA()).toBe true
      expect(new Bar().methodB()).toBe false
  
    it "adds a mixin's class methods as class methods", ->
      class Foo
        @methodA: -> true
        @methodB: -> false
        
      class Bar extends Mixable
        @include Foo
        
      expect(Bar.methodA()).toBe true
      expect(Bar.methodB()).toBe false
      
    it "calls the mixin's .included method", ->
      class Foo
        @included: (base) ->
          @includedBy = base
          
      class Bar extends Mixable
        @include Foo
        
      expect(Foo.includedBy).toBe Bar
      
    it "does not add the mixin's .included method", ->
      class Foo
        @included: ->
          
      class Bar extends Mixable
        @include Foo
        
      expect(Bar.included).toBeUndefined()
      
    it "does not add the mixin's .extended method", ->
      class Foo
        @extended: ->
          
      class Bar extends Mixable
        @include Foo
        
      expect(Bar.extended).toBeUndefined()
      