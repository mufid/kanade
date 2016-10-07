# Rubygem Kanade!

> かなでる 【奏でる】
> ichidan verb → conjugation / intransitive:
> to play an instrument (esp. string instruments)

Kanade membuat lantunan kode yang harmonis antara kode Ruby
dan kode JSON. Apapun sumbernya. JSON-REST? Ayo. Hanya membaca
dari lokal? Tidak apa. Kanade menerima untaian string dari JSON
dan menerjemahkannya. Kanade pun dapat melakukan sebaliknya,
dengan menerjemahkan object transfer data ke JSON.

## Instalasi

    gem 'kanade'

## Menggunakan Kanade

Buatlah sebuah berkas DTO, misalnya:

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

Terjemahkan dari JSON:

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


## Sintaks

Untuk mendefinisikan field:

    field :field_name, # Name field di Ruby
          as: :int, # Tipe data
          with: 'TheFieldName', # Nama field di JSON apabila tidak standar
          allow_null: true, # Ubah menjadi false agar Kanade melempar exception ketika bertemu nilai yang null

Tipe data yang tersedia dari asal (built-in):

- `:big_decimal`
- `:bool`
- `:fixnum`
- `:float`
- `:string`
- `:symbol`
- `:time`
- Atau, objek apapun yang meng-extend `Kanade::Dto`

## Menambahkan Pengkonversian untuk Tipe Data Khusus

    engine = Kanade::Engine.new
    engine.configure |c|
      c.add_converter :
    end

## Strategi Penamaan Field

Secara default, Kanade akan menggunakan mekanisme penamaan
snake_case. Tidak dapat dipungkiri bahwa penamaan ini
tidak lazim untuk beberapa landasan, misalnya di Java.
Sesuaikan saja Anda menerima dari data dengan kontrak apa.

    engine = Kanade::Engine.new
    engine.configure |c|
      c.naming_strategy :pascal_case
    end

Kanade akan otomatis mengkonversi penamaan di JSON menjadi
konvensi Ruby (`snake_case`)
