#!/bin/bash
ver=1.0-gcc3
for x in `cat /usr/portage/profiles/default-${ver}/packages.build`
do
	grep -E "${x}(-[^[:space:]]*)?[[:space:]]*$" /usr/portage/profiles/default-${ver}/packages | grep -v '^#' | sed -e 's:^\*::' | cat 
done
