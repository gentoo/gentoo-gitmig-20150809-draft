# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-objprelink.eclass,v 1.2 2001/10/04 22:16:05 danarmak Exp $
# Provides deps and functions for objprelink. Supports objprelink-admin.ptch.
ECLASS=kde-objprelink

use objprelink && DEPEND="$DEPEND >=dev-util/objprelink-0-r1"

kde-objprelink-patch() {
	debug-print-function kde-objprelink-patch $*
	use objprelink && cd ${S} && patch -p0 < /usr/share/objprelink/kde-admin-acinclude.patch
}

