" Forked from Larry Gilbert's syntax file
" github.com/L2G/vim-syntax-terraform

if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword nomadSection connection output provider variable
syn keyword nomadValueBool true false on off yes no

""" resource

syn keyword nomadResourceTypeBI
          \ job
          \ all_at_once
          \ constraint
          \ datacenters
          \ meta
          \ periodic
          \ priority
          \ region
          \ update
          \ group
          \ task
          \ service
          \ tags
          \ port
          \ check
          \
          \ contained

syn keyword nomadTodo         contained TODO FIXME XXX BUG
syn cluster nomadCommentGroup contains=nomadTodo
syn region  nomadComment      start="/\*" end="\*/" contains=@nomadCommentGroup,@Spell
syn region  nomadComment      start="#" end="$" contains=@nomadCommentGroup,@Spell
syn region  nomadComment      start="//" end="$" contains=@nomadCommentGroup,@Spell

syn match  nomadResource        /\<resource\>/ nextgroup=nomadResourceTypeStr skipwhite
syn region nomadResourceTypeStr start=/"/ end=/"/ contains=nomadResourceTypeBI
                              \ nextgroup=nomadResourceName skipwhite
syn region nomadResourceName    start=/"/ end=/"/
                              \ nextgroup=nomadResourceBlock skipwhite
""" provider
syn match  nomadProvider      /\<provider\>/ nextgroup=nomadProviderName skipwhite
syn region nomadProviderName  start=/"/ end=/"/ nextgroup=nomadProviderBlock skipwhite

""" provisioner
syn match  nomadProvisioner     /\<provisioner\>/ nextgroup=nomadProvisionerName skipwhite
syn region nomadProvisionerName start=/"/ end=/"/ nextgroup=nomadProvisionerBlock skipwhite

""" module
syn match  nomadModule     /\<module\>/ nextgroup=nomadModuleName skipwhite
syn region nomadModuleName start=/"/ end=/"/ nextgroup=nomadModuleBlock skipwhite

""" misc.
syn match nomadValueDec      "\<[0-9]\+\([kKmMgG]b\?\)\?\>"
syn match nomadValueHexaDec  "\<0x[0-9a-f]\+\([kKmMgG]b\?\)\?\>"
syn match nomadBraces        "[{}\[\]]"

""" skip \" in strings.
""" we may also want to pass \\" into a function to escape quotes.
syn region nomadValueString   start=/"/ skip=/\\\+"/ end=/"/ contains=nomadStringInterp
syn region nomadStringInterp  matchgroup=nomadBrackets start=/\${/ end=/}/ contains=nomadValueFunction contained
"" TODO match keywords here, not a-z+
syn region nomadValueFunction matchgroup=nomadBrackets start=/[a-z]\+(/ end=/)/ contains=nomadValueString,nomadValueFunction contained

hi def link nomadComment           Comment
hi def link nomadTodo              Todo
hi def link nomadBrackets          Operator
hi def link nomadProvider          Structure
hi def link nomadBraces            Delimiter
hi def link nomadProviderName      String
hi def link nomadResource          Structure
hi def link nomadResourceName      String
hi def link nomadResourceTypeBI    Tag
hi def link nomadResourceTypeStr   String
hi def link nomadSection           Structure
hi def link nomadStringInterp      Identifier
hi def link nomadValueBool         Boolean
hi def link nomadValueDec          Number
hi def link nomadValueHexaDec      Number
hi def link nomadValueString       String
hi def link nomadProvisioner       Structure
hi def link nomadProvisionerName   String
hi def link nomadModule            Structure
hi def link nomadModuleName        String
hi def link nomadValueFunction     Identifier

let b:current_syntax = "nomadform"
