# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-env/gnustep-env-0.1.ebuild,v 1.1 2004/07/23 14:06:25 fafhrd Exp $

DESCRIPTION="Exports GNUSTEP_LOCAL_ROOT"
HOMEPAGE="http://www.gentoo.org"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc ppc mips"
SLOT="0"
IUSE=""

src_install() {
	# Does anyone use GNUstep ?  Hopefully this will be fixed when
	# someone package GNUstep, otherwise should work just fine.
	insinto /etc/env.d
	doins ${FILESDIR}/10gnustep
}
