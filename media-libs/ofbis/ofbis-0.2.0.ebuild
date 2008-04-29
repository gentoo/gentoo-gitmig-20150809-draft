# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ofbis/ofbis-0.2.0.ebuild,v 1.1 2008/04/29 14:17:57 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="a library containing a few simple graphical routines for the Linux framebuffers."
HOMEPAGE="http://osis.nocrew.org/ofbis"
SRC_URI="ftp://ftp.nocrew.org/pub/osis/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	tc-export CC
	econf
	emake CFLAGS="${CFLAGS}" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog CREDITS DESIGN NEWS \
		OFBIS-VERSION README TODO
}
