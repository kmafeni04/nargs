# nargs
A command line argument parser for nelua

## Quick Start
```lua
local nargs = require "nargs"

local parser = nargs.new()
parser:pos_arg("input", "Input file")
parser:opt("output", "o", "Output file", "a.out", 1)
parser:opt("include", "I", "Include locations", "", nargs.MAX_ARG_LEN)

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

### nargs.ParserOption

```lua
local nargs.ParserOption = @record{
  long_name: string,
  short_name: string,
  desc: string,
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
  desc: string,
}
```

### nargs.ParserPosArg

```lua
local nargs.ParserPosArg = @record{
  name: string,
  desc: string,
  def: string,
  max_len: integer,
  values: sequence(string),
}
```

### nargs.Parser

```lua
local nargs.Parser = @record{
  name: string,
  desc: string,
  options: hashmap(string, nargs.ParserOption),
  flags: hashmap(string, nargs.ParserFlag),
  pos_args: sequence(nargs.ParserPosArg),
  cmds: hashmap(string, nargs.Parser),
  short_long: hashmap(string, string)
}
```

### nargs.new

```lua
function nargs.new(name: string, desc: string): nargs.Parser
```

### nargs.Parser:opt

```lua
function nargs.Parser:opt(long_name: string, short_name: string, desc: string, def: string, max_len: integer)
```

### nargs.Parser:flag

```lua
function nargs.Parser:flag(long_name: string, short_name: string, desc: string)
```

### nargs.Parser:pos_arg

```lua
function nargs.Parser:pos_arg(name: string, desc: string, def: string, max_len: integer)
```

### nargs.Parser:cmd

```lua
function nargs.Parser:cmd(name: string, desc: string): *nargs.Parser
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
