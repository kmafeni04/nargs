---@class PackageDependency
---@field name string package name as it will be used in file gen
---@field repo string git repo
---@field version? string git hash(#) or tag(v), defaults to "#HEAD"

---@class Package
---@field dependencies? PackageDependency[] List of package dependencies
---@field scripts? table<string, string> scripts that can be called with `nlpm script`

---@type Package
return {
  dependencies = {
    {
      name = "variant-nelua",
      repo = "https://github.com/kmafeni04/variant-nelua",
      version = "#c1dbeb2a1daa86d88a38deb24416b66149161e65",
    },
  },
  scripts = {},
}
