#!/bin/bash

#=========#
# OPTIONS #
#=========#

temp_folder=".complete"

#================#
# IMPLEMENTATION #
#================#

dir="$(dirname -- "$(readlink -fn -- "${0}")")"
id=$(stat -c %Z "${1}")
if [[ ! -f "${temp_folder}"/${id} ]]
then
 rm "${temp_folder}"/* && "${dir}"/complete.sh "${@}" > "${temp_folder}"/${id} 2>&1
fi
cat "${temp_folder}"/*
