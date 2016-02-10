#!/bin/bash

#=========#
# OPTIONS #
#=========#

temp_folder=".complete"

#================#
# IMPLEMENTATION #
#================#

dir="$(dirname -- "$(readlink -fn -- "${0}")")"
T1=$(stat -c %Z "${1}")
if [[ ! -f "${temp_folder}"/${T1} ]]
then
 rm "${temp_folder}"/* && "${dir}"/complete.sh "${@}" > "${temp_folder}"/${T1} 2>&1
fi
cat "${temp_folder}"/*
