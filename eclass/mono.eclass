# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mono.eclass,v 1.2 2004/05/27 01:43:26 latexer Exp $
#
# Author : foser <foser@gentoo.org>
#
# mono eclass
# right now only circumvents a sandbox violation by setting a mono env var

ECLASS="mono"
INHERITED="$INHERITED $ECLASS"

# >=mono-0.92 versions using mcs -pkg:foo-sharp require shared memory, so we set the 
# shared dir to ${T} so that ${T}/.wapi can be used during the install process.
export MONO_SHARED_DIR=${T}
