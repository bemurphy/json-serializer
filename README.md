json-serializer
===============

Customizes JSON output through serializer objects.

A minimal implementation of [active_model_serializers][active_model_serializers] gem.

Installation
------------

```
gem install json-serializer
```

Usage
-----

### Basics

Here's a simple example:

```ruby
require "json_serializer"

class UserSerializer < JsonSerializer
  attribute :id
  attribute :first_name
  attribute :last_name
end
```

In this case, we defined a new serializer class and specified the attributes
we would like to include in the serialized form.

```ruby
user = User.create(first_name: "Sonny", last_name: "Moore", admin: true)

UserSerializer.new(user).to_json
# => "{\"id\":1,\"first_name\":\"Sonny\",\"last_name\":\"Moore\"}"
```

### Arrays

A serializer can be used for objects contained in an array:

```ruby
require "json_serializer"

class PostSerializer < JsonSerializer
  attribute :id
  attribute :title
  attribute :body
end

posts = []
posts << Post.create(title: "Post 1", body: "Hello!")
posts << Post.create(title: "Post 2", body: "Goodbye!")

PostSerializer.new(posts).to_json
```

Given the example above, it will return a json output like:

```ruby
[
  { "title": "Post 1", "body": "Hello!" },
  { "title": "Post 2", "body": "Goodbye!" }
]
```

### Attributes

By default, before looking up the attribute on the object, it checks the presence
of a method with the name of the attribute. This allow serializes to include
properties in addition to the object attributes or customize the result of a
specified attribute. You can access the object being serialized with the +object+
method.

```ruby
require "json_serializer"

class UserSerializer < JsonSerializer
  attribute :id
  attribute :first_name
  attribute :last_name
  attribute :full_name

  def full_name
    object.first_name + " " + object.last_name
  end
end

user = User.create(first_name: "Sonny", last_name: "Moore")

UserSerializer.new(user).to_json
# => "{\"id\":1,\"first_name\":\"Sonny\",\"last_name\":\"Moore\",\"full_name\":\"Sonny Moore\"}"
```

If you would like direct, low-level control of attribute serialization, you can
completely override the attributes method to return the hash you need:

```ruby
require "json_serializer"

class UserSerializer < JsonSerializer
  attribute :id
  attribute :first_name
  attribute :last_name

  attr :scope

  def initialize(object, scope)
    super(object)
    @scope = scope
  end

  def attributes
    hash = super
    hash.merge!(admin: object.admin) if scope.admin?
    hash
  end
end
```

[active_model_serializers]: https://github.com/rails-api/active_model_serializers
