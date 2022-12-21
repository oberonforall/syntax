# syntax
A collection of resources and scripts to work on and play with the minimal syntax of the Oberon programming language.


## Use the repo
### Generate the language file
```bash
> ./scripts/generate-language --help
```
e.g.
```bash
> ./scripts/generate-language
```
to dump the language file to the assumed default location in the project.

### Generate the eBNF of `oberon`
```bash
> ./scripts/generate-ebnf --help
```
e.g.
```bash
> ./scripts/generate-ebnf --path language.json --all
```
to generate all the plain text eBNF production rules of the syntax of the language.

### Generate the static website pages
```bash
> ./scripts/generate-website --help
```
e.g.
```bash
> ./scripts/generate-website --path language.json --website website/ --templates html/templates/
```
will generate the static pages of the syntax from `language.json`, with the templates in `html/templates/` and dump the resulting `HTML` files to `website/`.
these pages can be used in the [website of the project](https://github.com/oberonforall/oberonforall.github.io) by moving them inside the [`syntax/` directory](https://github.com/oberonforall/oberonforall.github.io/tree/main/syntax).
one can see the local website by running `<BROWSER> website/index.html`.

one might want to add a `style.css` at the root of the repo, i.e. next to `./website/`, in order to style the generated website pages, e.g. the [`CSS` of the official website](https://raw.githubusercontent.com/oberonforall/oberonforall.github.io/main/style.css).

### Clean the repo
```bash
> ./scripts/clean
```
