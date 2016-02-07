#!/bin/bash

key='`'

line=$(grep -n ${key} "${1}" | grep -o "^[0-9]*")

if [[ -z ${line} ]]
  then exit 1
fi

IFS='%'
str_line=$(sed "${line}q; d" "${1}")
str_line_half=$(printf ${str_line} | cut -d ${key} -f1)
str_tail=$(printf ${str_line_half} | rev | cut -d '.' -f1 | cut -d '>' -f1 | cut -d ':' -f1 | cut -d '(' -f1 | cut -d ',' -f1 | cut -d ' ' -f1 | rev)

column=$(( ${#str_line_half} - ${#str_tail} + 1 ))

clang "${@}" -fsyntax-only -Xclang -code-completion-macros -Xclang -code-completion-at="${1}":${line}:${column} | grep "^COMPLETION: ${str_tail}" | sed "s_^COMPLETION: __1 ; s_^.* : __1 ; s_#\]_ _1 ; s_\[#__g ; s_#\]__g ; s_<#__g ; s_#>__g ; s_{#__g ; s_#}__g"