#!/bin/sh
# Copyright 2009 Gentoo Foundation
# Distributed under the terms of the MIT/X11 license

# Editor wrapper script, executes ${EDITOR} with arguments $@

if [ -z "${EDITOR}" ]; then
    # Try to get EDITOR from system profile
    EDITOR=$(. /etc/profile &>/dev/null; echo "${EDITOR}")
fi

if [ -z "${EDITOR}" ]; then
    echo "$0: The EDITOR variable must be set" >&2
    exit 1
fi

exec ${EDITOR} "$@"
