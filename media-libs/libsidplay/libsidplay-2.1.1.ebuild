# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsidplay/libsidplay-2.1.1.ebuild,v 1.5 2004/09/03 20:16:08 eradicator Exp $

inherit libtool eutils

MY_PN="sidplay-libs"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="C64 SID player library"
HOMEPAGE="http://sidplay2.sourceforge.net/"
SRC_URI="mirror://sourceforge/sidplay2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ~ppc sparc hppa amd64 ~alpha"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/libsidplay2-gcc34.patch

	elibtoolize
}

src_compile() {
	econf --with-pic || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	cd ${S}/libsidplay
	docinto libsidplay
	dodoc AUTHORS ChangeLog README TODO

	cd ${S}/libsidutils
	docinto libsidutils
	dodoc AUTHORS ChangeLog README TODO

	cd ${S}/resid
	docinto resid
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
