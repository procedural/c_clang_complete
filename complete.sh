#!/bin/bash

#========#
# COLORS #
#========#

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
normal="\\\033[0m"
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
body=$(sed "${line}q; d" "${1}" | cut -d ${find} -f1)
tail=$(echo "${body}" | rev | \
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
column=$((${#body} - ${#tail} + 1))
format="s_#\]_#\] _1; s_\[#_${return_color}_g; s_#\]_${normal}_g; s_<#_${argument_color}_g; s_#>_${normal}_g; s_{#, _,${default_argument_color} \$_g; s_#}_${normal}_g"
clang=$(clang "${@}" -fcolor-diagnostics -fsyntax-only -Xclang -code-completion-macros -Xclang -code-completion-patterns -Xclang -code-completion-brief-comments -Xclang -code-completion-at="${1}":${line}:${column} \
| sed -z "s_\n__g; s_OVERLOAD: _\n${normal}OVERLOAD: _g; s_COMPLETION: _\n${normal}COMPLETION: _g" | sed "${format}; /^$/d")
overload=$(echo "${clang}" | grep "OVERLOAD: ")
complete=$(echo "${clang}" | sed "/COMPLETION: Pattern : /d" | grep "COMPLETION: ${tail}")
patterns=$(echo "${clang}" | grep "COMPLETION: Pattern : "   | grep "${tail}")
if [[ ! -z ${overload} ]]; then echo -e "\n${overload}"; fi
if [[ ! -z ${complete} ]]; then echo -e "\n${complete}"; fi
if [[ ! -z ${patterns} ]]; then echo -e "\n${patterns}"; fi
