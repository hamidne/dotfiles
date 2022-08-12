# Languages

> language server data & configurations

## how to add a language server

> mason exposes its own API and package names are different than lspconfig server name.
> for more info go to [mason mapping page](https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md)

``` lua
local M = {} -- define a variable to hold language data

M.package = '' -- mason package name

M.server = '' -- lspconfig server name

M.config = {} -- lspconfig configuration

return M -- return the language data
```
