# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/psmark/psmark-2.1.ebuild,v 1.1 2006/07/18 04:40:02 nerdboy Exp $

inherit eutils toolchain-funcs

MY_PN=${PN}-v
MY_P=${MY_PN}${PV}
S=${WORKDIR}/${PN}

IUSE=""
DESCRIPTION="Prints watermark-like text on any PostScript document."
HOMEPAGE="http://www.antitachyon.com/Content/10_Produkte/50_Utilities/psmark/"
SRC_URI="http://www.antitachyon.com/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_compile() {
	cd ${S}
	epatch ${FILESDIR}/${P}-string.patch || die "epatch failed"
	make CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	dobin psmark
	doman psmark.1
	dodoc README CHANGELOG COPYING
}
