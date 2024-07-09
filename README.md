# Nix Templating Tests
A few quick examples of different templating methods available in nix.

## Not Included
No examples using `substitute` rather than `substituteAll`.

## Run "Tests"
```bash
nix run github:noblepayne/nix-templating-tests
substituteAll
hello from substituteAll

envsubst
hello from envsubst

nixTmpl
hello from nixTmpl

jinja2
hello from jinja2
```
```
