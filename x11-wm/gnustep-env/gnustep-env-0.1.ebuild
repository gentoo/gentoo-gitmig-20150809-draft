# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/gnustep-env/gnustep-env-0.1.ebuild,v 1.14 2004/04/27 16:49:15 pvdabeel Exp $

DESCRIPTION="Exports GNUSTEP_LOCAL_ROOT"
HOMEPAGE="http://www.gentoo.org"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ppc"
SLOT="0"

src_install() {
	# Does anyone use GNUstep ?  Hopefully this will be fixed when
	# someone package GNUstep, otherwise should work just fine.
	insinto /etc/env.d
	doins ${FILESDIR}/10gnustep
}
