# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unarj/unarj-2.63a-r1.ebuild,v 1.11 2005/01/01 11:59:40 eradicator Exp $

DESCRIPTION="Utility for opening arj archives"
HOMEPAGE="http://ibiblio.org/pub/Linux/utils/compress/"
SRC_URI="http://ibiblio.org/pub/Linux/utils/compress/${P}.tar.gz"

LICENSE="arj"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha arm amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	sed -i "/^CFLAGS/s:-O2:${CFLAGS}:" ${S}/Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin unarj || die
	dodoc unarj.txt technote.txt readme.txt
}
