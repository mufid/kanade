# Kanade - Harmonize External API with Strong-typed Ruby Object [![Build Status](https://travis-ci.org/mufid/kanade.png)](https://travis-ci.org/mufid/kanade)

A JSON parser (intended for client). Like Gson / Jackson / JSON.NET, but for Ruby.

> かなでる 【奏でる】
> ichidan verb → conjugation / intransitive:
> to play an instrument (esp. string instruments)

Kanade harmonize your Ruby and any JSON-REST API into strong-typed
Ruby object.

## Installation

    gem 'kanade'

## Using Kanade

Create a DTO file, for example:

    class ProductList < Kanade::Dto
      field :id, as: :fixnum
      field :products, as: :list, of: Product
    end

    class Product < Kanade::Dto
      field :id, as: :fixnum
      field :name, as: :string
      field :expire_at, as: :date_time
      field :price, as: :big_decimal
      field :available, as: :bool
    end

Deserialize from JSON:

    json = '
    {
      "products": [
      {
        "price": "35.5"
      }]
    }
    '

    engine = Kanade::Engine.new
    engine.configure do |config|
      config.contract = :camel_case
      config.enum = :upper_snake_case
    end

    list = engine.deserialize(ProductList, json)
    list.products.first.price # => A big decimal of 35.5


## Syntax

To define a field:

    field :field_name, # field name in Ruby
          as: :int, # Data type
          with: 'TheFieldName', # Nama field di JSON apabila tidak standar

Built in data type:

- `:big_decimal`
- `:bool`
- `:fixnum`
- `:float`
- `:string`
- `:symbol`
- `:time`
- Atau, objek apapun yang meng-extend `Kanade::Dto`

## Naming strategy


Internally, as Ruby object, Kanade will respect Ruby convention
by using snake_case naming. However, your JSON-REST API may have
another convention. For example, in Java (GSON/Jackson), by default
you will have camelCase naming. Kanade can understand this different
by specifying a naming strategy.

    engine = Kanade::Engine.new
    engine.configure |c|
      c.naming_strategy :pascal_case
    end

Kanade will automatically convert the naming from JSON to Ruby object
and vice versa.
