{ extend } = if require? then require "../dist/mixable" else window

describe "extend", ->
  it "adds an object's methods", ->
    Foo =
      methodA: -> true
      methodB: -> false
      
    bar = {}
    extend bar, Foo
      
    expect(bar.methodA()).toBe true
    expect(bar.methodB()).toBe false
    
  it "adds an object's methods as class methods", ->
    Foo =
      methodA: -> true
      methodB: -> false
      
    class Bar
      extend @, Foo
      
    expect(Bar.methodA()).toBe true
    expect(Bar.methodB()).toBe false

  it "adds a mixin's instance methods as class methods", ->
    class Foo
      methodA: -> true
      methodB: -> false
      
    class Bar
      extend @, Foo
      
    expect(Bar.methodA()).toBe true
    expect(Bar.methodB()).toBe false
    
  it "calls the mixin's .extended method", ->
    class Foo
      @extended: (base) ->
        @extendedBy = base
        
    class Bar
      extend @, Foo
      
    expect(Foo.extendedBy).toBe Bar
    