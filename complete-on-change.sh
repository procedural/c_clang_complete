#!/bin/bash

#=========#
# OPTIONS #
#=========#

temp_folder=".complete"

#================#
# IMPLEMENTATION #
#================#

dir="$(dirname -- "$(readlink -fn -- "${0}")")"
pwd="$(dirname -- "$(readlink -fn -- "${1}")")"
tmp="${pwd}/${temp_folder}"
id=$(stat -c %Z "${1}")
if [[ ! -f "${tmp}"/"${id}" ]]
then
  rm -f "${tmp}"/* && "${dir}"/complete.sh "${@}" > "${tmp}"/"${id}" 2>&1
fi
cat "${tmp}"/*
