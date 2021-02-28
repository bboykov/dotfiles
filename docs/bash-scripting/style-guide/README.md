# Bash Style Guide

I follow [Google's Shell Style Guide][google-shell-style-guide]. It is a good
guideline for consistency and good practices. Here I will note things that are
not in the guide or I prefer despite the guide's recommendation.

[google-shell-style-guide]: https://google.github.io/styleguide/shellguide.html

## linters, fixers and checkers

- [shellcheck](https://github.com/koalaman/shellcheck)
- [shfmt](https://github.com/mvdan/sh)

## Configurations

### vim

```vim
Plug 'dense-analysis/ale'
let g:ale_linters = {
\ 'sh': ['shellcheck'] ,
\ }
let g:ale_fixers = {
\   'sh': ['shfmt'],
\ }
```
