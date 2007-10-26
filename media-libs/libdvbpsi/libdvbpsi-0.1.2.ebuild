# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvbpsi/libdvbpsi-0.1.2.ebuild,v 1.8 2007/10/26 19:57:22 zzam Exp $

DESCRIPTION="library for MPEG TS/DVB PSI tables decoding and generation"
HOMEPAGE="http://www.videolan.org/libdvbpsi"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc -sparc"
IUSE=""

DEPEND=">=app-doc/doxygen-1.2.16
	media-gfx/graphviz"
RDEPEND=""

src_compile() {

	econf \
		--enable-release || die "econf failed"

	emake || die "emake failed"

	make doc || die "make doc failed"

}

src_install () {

	einstall || die "einstall failed"

	dohtml "${S}"/doc/doxygen/html/*

	cd "${S}"
	dodoc AUTHORS INSTALL README NEWS

}
