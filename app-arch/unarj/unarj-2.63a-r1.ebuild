# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unarj/unarj-2.63a-r1.ebuild,v 1.8 2004/03/12 11:11:07 mr_bones_ Exp $

DESCRIPTION="Utility for opening arj archives"
HOMEPAGE="http://ibiblio.org/pub/Linux/utils/compress/"
SRC_URI="http://ibiblio.org/pub/Linux/utils/compress/${P}.tar.gz"

LICENSE="arj"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"

src_unpack() {
	unpack ${A}
	sed -i "/^CFLAGS/s:-O2:${CFLAGS}:" ${S}/Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin unarj
	dodoc unarj.txt technote.txt readme.txt
}
