<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-yellow.svg" alt="License: MIT"></a>
<a href="https://github.com/tenhobi/effective_dart"><img src="https://img.shields.io/badge/style-effective_dart-blue.svg" alt="style: effective dart"></a>
<a href="https://travis-ci.org/github/owczaro/o_i18n_generator"><img src="https://travis-ci.org/owczaro/o_i18n_generator.svg?branch=master" alt="Travis CI"></a>

---


# Description

Merges [language-tag].json files from given path in root and all dependant packages. Creates a map with translations. You can redirect (from one key to another), overwrite and fill missing translations with values from default language.


## Implementation

Visit [pub.dev -> install](https://pub.dev/packages/o_i18n_generator/install).


## Preparing `.json` files

1. Files containing translations must have names (case sensitive) like keys from [language_tags.dart](https://github.com/owczaro/o_i18n_generator/tree/master/lib/src/data/language_tags.dart).
1. Files must contain only correct Map. For example:
```json
{'foo': 'bar', 'deeper_example': {'deeper_key': 'deeper_value'}, 'test': '-->deeper_example.deeper_key'}
```


## Translation redirecting "-->"

As you probably notice above, you can get translation from another key. All you need to do is to add "-->" at the beginning of a value and after that (without any space) a key of a source value. If the source value is nested, you have to join all keys which lead to the value by a dot.


## Overwriting translations

You can overwrite a translation from each package. You just need to add overwriting translation to `assets/i18n` directory.
Remember, filename must be the same as language tag you want to overwrite.


## How to use

1. Do not place or modify your files in given target directory. The script removes its content every time.
1. Place `.json` files in source dir (by default: `lib/src/i18n`).
1. Run the command below in the root directory of your project:
```bash
pub run o_i18n_generator
```
1. In order to see default values and help, just run:
```bash
pub run o_i18n_generator --help
```

## What files are generated?

You can choose `output-extension`. By default it is `dart`. But you can select `json` either.
If you want to generate `dart` files, command generates files containing a map (name of map is language tag from [language_tags.dart](https://github.com/owczaro/o_i18n_generator/tree/master/lib/src/data/language_tags.dart) but without a dash) of translations.
Besides it generates `LocaleLoader` class, which contains all supported language tags and helps to load translation map easily.


## Commercial Use

If you use this code in commercial project, please donate me via GitHub Sponsors. I do the same for packages which I use, because it ensures stable development for all of us!
