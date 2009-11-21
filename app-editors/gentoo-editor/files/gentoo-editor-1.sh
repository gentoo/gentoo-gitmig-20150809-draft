#!/bin/sh
# Copyright 2009 Gentoo Foundation
# Distributed under the terms of the MIT license

# Editor wrapper script, executes ${EDITOR} on file $1.
# We disallow options and multiple file name arguments on purpose, so
# that packages' configure scripts cannot sniff out the type of editor.

if [ $# -ne 1 ]; then
    echo "$0: Exactly one argument required" >&2
    exit 1
fi

file=$1
if [ "${file#-}" != "${file}" ]; then
    # Argument is supposed to be a file name, not an option
    file=./${file}
fi

if [ -z "${EDITOR}" ]; then
    # Try to get EDITOR from system profile
    EDITOR=$(source /etc/profile &>/dev/null; echo "${EDITOR}")
fi

if [ -z "${EDITOR}" ]; then
    echo "$0: The EDITOR variable must be set" >&2
    exit 1
fi

exec ${EDITOR} "${file}"
