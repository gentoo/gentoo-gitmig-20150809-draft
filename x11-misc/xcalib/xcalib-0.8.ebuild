# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcalib/xcalib-0.8.ebuild,v 1.1 2007/11/01 10:58:19 hansmi Exp $

inherit eutils toolchain-funcs

DESCRIPTION="xcalib is a tiny monitor calibration loader for X.org"
HOMEPAGE="http://www.etg.e-technik.uni-erlangen.de/web/doe/xcalib/"
SRC_URI="http://www.etg.e-technik.uni-erlangen.de/web/doe/xcalib/xcalib-source-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm
	x11-proto/xf86vidmodeproto
"
RDEPEND=""

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die 'make failed'
}

src_install() {
	dobin xcalib
	dodoc README

	docinto profiles
	dodoc *.icm *.icc
}
