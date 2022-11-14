# syntax
A collection of resources and scripts to work on and play with the minimal syntax of the Oberon programming language.


## Use the repo
### Generate the language file
```bash
nushell> ./scripts/generate-language | from json | save language.json
```

### Generate the static website pages
```bash
> ./script/generate-website
```
you might want to add `style.css` at the root of the repo, i.e. next to `./website/`, in order to style the generated website pages.

### Clean the repo
```bash
> ./scripts/clean
```
