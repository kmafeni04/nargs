# nargs
A command line argument parser for nelua

## How to install

Add to your [nlpm](https://github.com/kmafeni04/nlpm) package dependencies
```lua
{
  name = "nargs",
  repo = "https://github.com/kmafeni04/nargs",
  version = "COMMIT-HASH-OR-TAG",
},
```

## Quick Start
```lua
local nargs = require "nargs"

local parser = nargs.new()
parser:pos_arg({ "input", "Input file" })
parser:opt({ "output", "o", "Output file", "a.out", max_len = 1 })
parser:opt({ "include", "I", "Include locations", max_len = nargs.MAX_ARG_LEN })

local args = parser:parse()

local args = parser:parse({ "foo", "-I=/usr/local/include", "--include=src", "-o", "bar" })

local input = args["input"]:get_pos_arg()
print(input[1]) -- foo

local output = args["output"]:get_opt()
print(output[1]) -- bar

local include = args["include"]:get_opt()
print(include[1], include[2]) -- /usr/local/include src

nargs.destroy_args(args)
```
## Reference

### nargs

```lua
local nargs = @record{}
```

### nargs.MAX_ARG_LEN

```lua
local nargs.MAX_ARG_LEN: integer <const> = 9223372036854775807 -- INT64_MAX
```

### nargs.ParserOpt

```lua
local nargs.ParserOpt = @record{
  long_name: string,
  short_name: string,
  placeholder: string,
  help: string,
  def: string,
  max_len: integer,
  values: sequence(string),
}
```

### nargs.ParserFlag

```lua
local nargs.ParserFlag = @record{
  long_name: string,
  short_name: string,
  help: string,
}
```

### nargs.ParserPosArg

```lua
local nargs.ParserPosArg = @record{
  name: string,
  help: string,
  def: string,
  max_len: integer,
  optional: boolean,
  values: sequence(string),
}
```

### nargs.Parser

```lua
local nargs.Parser = @record{
  name: string,
  desc: string,
  help: string,
  opts: hashmap(string, nargs.ParserOpt),
  flags: hashmap(string, nargs.ParserFlag),
  pos_args: sequence(nargs.ParserPosArg),
  cmds: hashmap(string, nargs.Parser),
  short_long: hashmap(string, string)
}
```

### nargs.new

```lua
function nargs.new(conf: nargs.Parser): nargs.Parser
```

### nargs.Parser:opt

```lua
function nargs.Parser:opt(conf: nargs.ParserOpt): *nargs.ParserOpt
```

### nargs.Parser:flag

```lua
function nargs.Parser:flag(conf: nargs.ParserFlag): *nargs.ParserFlag
```

### nargs.Parser:pos_arg

```lua
function nargs.Parser:pos_arg(conf: nargs.ParserPosArg): *nargs.ParserPosArg
```

### nargs.Parser:cmd

```lua
function nargs.Parser:cmd(conf: nargs.Parser): *nargs.Parser
```

### nargs.ParsedResult

```lua
local nargs.ParsedResult = @Sum(record{
  opt: sequence(string),
  flag: boolean,
  pos_arg: sequence(string),
  cmd: hashmap(string, *nargs.ParsedCmdResult),
})
```

### nargs.ParsedCmdResult

```lua
nargs.ParsedCmdResult = @record{
  res: nargs.ParsedResult
}
```

### nargs.Parser:get_help

```lua
function nargs.Parser:get_help(): string
```

### nargs.Parser:print_help

```lua
function nargs.Parser:print_help()
```

### nargs.Parser:parse

```lua
function nargs.Parser:parse(args: span(string)): (hashmap(string, nargs.ParsedResult), sequence(string))
```

### nargs.destroy_args

```lua
function nargs.destroy_args(args: hashmap(string, nargs.ParsedResult))
```

## Acknowledgement
- [argparse](https://github.com/mpeterv/argparse)
- [flag.h](https://github.com/tsoding/flag.h)
- [arrr](https://github.com/DarkWiiPlayer/arrr)
