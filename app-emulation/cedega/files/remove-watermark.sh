#!/bin/bash

file="$1"
if [ ! -e "${file}" ] ; then
	echo "The file '${file}' doesn't seem to exist."
	echo "Aborting!"
	exit 1
fi

dd \
	if=/dev/zero \
	of="${file}" \
	seek=16 \
	count=20 \
	bs=1 \
	conv=notrunc
