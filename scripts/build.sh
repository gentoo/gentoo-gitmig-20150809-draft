#!/bin/bash

if [ "${1}" ]; then
	ver=${1}
else
	ver=x86-2.0
fi

for x in `cat /usr/portage/profiles/default-${ver}/packages.build`
do
	grep -E "${x}(-[^[:space:]]*)?[[:space:]]*$" /usr/portage/profiles/default-${ver}/packages | grep -v '^#' | sed -e 's:^\*::' | cat 
done
