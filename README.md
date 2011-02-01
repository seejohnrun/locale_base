# LocaleBase - EasyTranslate backed YAML/object translation in Ruby

This gem makes translating any nested structure easy.  This is particularly useful when trying to translate YAML files as a basis for locale I18n translations.
Since EasyTranslate (a dependency) uses POST, we are able to reduce the number of calls (and thus the time) we spend making calls to the API.

---

## Installation

    $ gem install locale_base

---

## Usage

### Arrays

Arrays are translated directly

    locale = LocaleBase::Translator.new ['one', 'two', 'three']
    locale.translate(:to => :spanish) # ['uno', 'dos', 'tres']

### Hashes

When hashes are translated, keys are left alone

    locale = LocaleBase::Translator.new { 'first' => ['one', 'two', 'three'] }
		locale.translate(:to => :spanish) # { 'first' => ['uno', 'dos', 'tres'] }

Also, escapes are obeyed all throughout, so you can do:

    locale = LocaleBase::Translator.new { 'first' => 'hello {{2x * y}}' }
    locale.translate(:to => :spanish) # { 'first' => 'hola {{2x * y}}' }

### Any nested Hash / Array mix

Works as a combination of the above two

### YAML

Translating YAML is easy because its just a nested structure

    locale = LocaleBase::Translator.new YAML::load_file('something.yml')
    YAML::dump locale.translate(:to => :spanish)

---

### Known Issues

* putting two {{}} blocks right next two each other will result in a space in-between due to the way that Google Translate handles .notranslate blocks - This will hopefully be fixed soon but shouldn't get in your way.

### Coming soon

* A lightweight CLI for translating YAML / JSON files from the command line
* Support for larger files (chunking)

--- 

### Author

* John Crepezzi - john.crepezzi@gmail.com

---

### License

(The MIT License)

Copyright © 2010-2011 John Crepezzi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
