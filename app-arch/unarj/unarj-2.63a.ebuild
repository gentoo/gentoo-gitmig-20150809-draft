# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unarj/unarj-2.63a.ebuild,v 1.2 2002/07/19 21:55:16 rphillips Exp $

# Free to use unarj utility. Can be distributed but copyright has to remain
# intact. 

DESCRIPTION="Utility for opening arj archives."
HOMEPAGE="http://ibiblio.org/pub/Linux/utils/compress/"
LICENSE="arj"
DEPEND="virtual/glibc
		>=sys-apps/baselayout-1.8.0"
RDEPEND="${DEPEND}"
SRC_URI="http://ibiblio.org/pub/Linux/utils/compress/${P}.tar.gz"
SLOT="0"
KEYWORDS="x86"

src_compile () {
	emake || die
}

src_install () {
	insinto /opt/bin
	doins unarj
	dodoc unarj.txt technote.txt readme.txt
}
