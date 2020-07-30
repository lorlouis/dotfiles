syntax match plan_ish /^ *\~/
syntax match plan_waiting /\(^ *[-\~+ ]\)\@<=?\( \)\@=/
syntax match plan_done /^ *-/
syntax match plan_todo /^ *+/
syntax match plan_urgent /\(^ *[-\~+ ]\)\@<=!\( \)\@=/
syntax match delim /[(){}\[\]]/
syntax match plan_tag_def /^[ ]\{-}\[.*\]$/ contains=plan_tag
syntax match plan_tag /\(^[ ]\{-}\[\)\@<=[^-+?!]*\(\]$\)\@=/
syntax match plan_waiting_mod /\(^ *[-\~+ ]? \)\@<=.*/
syntax match plan_urgent_mod /\(^ *[-\~+]! \)\@<=.*/
syntax match plan_ish_mod /\(^ *\~ \)\@<=.*/
syntax match plan_todo_mod /\(^ *+ \)\@<=.*/
syntax match str /["][^"]*["]/
syntax match str2 /['][^']*[']/
syntax match arrow /->/
syntax match points2 /:/

highlight link delim Number
highlight link plan_tag Underlined
highlight link plan_tag_def Repeat
highlight link points2 Repeat
highlight link plan_done Typedef
highlight link plan_todo Constant
highlight link plan_waiting Special
highlight link plan_ish NonText
highlight link plan_urgent SpellBad
highlight link plan_waiting_mod SpellCap
highlight link plan_urgent_mod SpellBad
highlight link plan_ish_mod SpellRare
highlight link plan_todo_mod DiffChange
highlight link str Whitespace
highlight link str2 Whitespace
highlight link arrow Number
