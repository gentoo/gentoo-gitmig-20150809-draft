# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mono.eclass,v 1.1 2003/02/27 16:50:51 foser Exp $
#
# Author : foser <foser@gentoo.org>
#
# mono eclass
# right now only circumvents a sandbox violation by setting a mono env var

ECLASS="mono"
INHERITED="$INHERITED $ECLASS"

export MONO_DISABLE_SHM=1
