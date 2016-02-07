#!/bin/bash

#========#
# COLORS #
#========#

nil="\\\033[0m"
red="\\\033[31m"
gray="\\\033[1;30m"
blue="\\\033[34m"
pink="\\\033[1;35m"
cyan="\\\033[36m"
white="\\\033[1;37m"
black="\\\033[30m"
green="\\\033[32m"
brown="\\\033[33m"
yellow="\\\033[1;33m"
purple="\\\033[35m"
bg_black="\\\033[40m"
bg_white="\\\033[47m"
light_red="\\\033[1;31m"
light_gray="\\\033[37m"
light_blue="\\\033[1;34m"
light_cyan="\\\033[1;36m"
light_green="\\\033[1;32m"

#=========#
# OPTIONS #
#=========#

find='`'
return_color=${light_cyan}
argument_color=${light_green}
default_argument_color=${light_red}

#================#
# IMPLEMENTATION #
#================#

IFS='%'
line=$(grep -n ${find} "${1}" | grep -o "^[0-9]*")
if [[ -z ${line} ]]; then exit 1; fi
str_line=$(sed "${line}q; d" "${1}")
str_line_half=$(echo "${str_line}" | cut -d ${find} -f1)
str_tail=$(echo "${str_line_half}" | rev | \
cut -d '{' -f1 | \
cut -d '}' -f1 | \
cut -d '[' -f1 | \
cut -d ']' -f1 | \
cut -d '#' -f1 | \
cut -d '(' -f1 | \
cut -d ')' -f1 | \
cut -d ';' -f1 | \
cut -d ':' -f1 | \
cut -d '.' -f1 | \
cut -d '+' -f1 | \
cut -d '-' -f1 | \
cut -d '*' -f1 | \
cut -d '/' -f1 | \
cut -d '%' -f1 | \
cut -d '^' -f1 | \
cut -d '&' -f1 | \
cut -d '|' -f1 | \
cut -d '~' -f1 | \
cut -d '!' -f1 | \
cut -d '=' -f1 | \
cut -d '<' -f1 | \
cut -d '>' -f1 | \
cut -d ',' -f1 | \
cut -d ' ' -f1 | rev)
column=$((${#str_line_half} - ${#str_tail} + 1))
clang_output=$(clang "${@}" -fcolor-diagnostics -fsyntax-only -Xclang -code-completion-macros -Xclang -code-completion-patterns -Xclang -code-completion-brief-comments -Xclang -code-completion-at="${1}":${line}:${column})
fmt="s_#\]_#\] _1; s_\[#_${return_color}_g; s_#\]_${nil}_g; s_<#_${argument_color}_g; s_#>_${nil}_g; s_{#, _,${default_argument_color} \$_g; s_#}_${nil}_g"
clang_output=$(echo "${clang_output}" | sed -z "s_\n__g; s_OVERLOAD: _\nOVERLOAD: _g; s_COMPLETION: _\nCOMPLETION: _g")
complete=$(echo "${clang_output}" | sed "/^OVERLOAD: /d; /^COMPLETION: Pattern : /d; /^$/d")
overload=$(echo "${clang_output}" | grep "^OVERLOAD: ")
complete=$(echo "${clang_output}" | grep "^COMPLETION: ${str_tail}")
patterns=$(echo "${clang_output}" | grep "^COMPLETION: Pattern : ")
overload=$(echo "${overload}" | sed "${fmt}")
complete=$(echo "${complete}" | sed "${fmt}")
patterns=$(echo "${patterns}" | sed "${fmt}")
echo
if [[ ! -z ${overload} ]]; then echo -e "${overload}"; echo; fi
if [[ ! -z ${complete} ]]; then echo -e "${complete}"; echo; fi
if [[ ! -z ${patterns} ]]; then echo -e "${patterns}"; echo; fi
