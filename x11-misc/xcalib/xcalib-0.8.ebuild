# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcalib/xcalib-0.8.ebuild,v 1.4 2008/04/14 11:36:52 flameeyes Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="xcalib is a tiny monitor calibration loader for X.org"
HOMEPAGE="http://www.etg.e-technik.uni-erlangen.de/web/doe/xcalib/"
SRC_URI="http://www.etg.e-technik.uni-erlangen.de/web/doe/xcalib/xcalib-source-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm"

DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-ldflags.patch"
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		XINCLUDEDIR=/usr/include \
		XLIBDIR=/usr/$(get_libdir) \
		|| die 'make failed'
}

src_install() {
	dobin xcalib
	dodoc README

	docinto profiles
	dodoc *.icm *.icc
}
