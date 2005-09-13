# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvbpsi/libdvbpsi-0.1.4-r1.ebuild,v 1.2 2005/09/13 19:51:50 agriffis Exp $

IUSE="doc"

MY_P=${PN}3-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="library for MPEG TS/DVB PSI tables decoding and generation"
HOMEPAGE="http://www.videolan.org/libdvbpsi"
SRC_URI="http://www.videolan.org/pub/videolan/${PN}/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# doxygen missing: ~ia64
KEYWORDS="alpha amd64 ~ppc ~sparc ~x86"

DEPEND="doc? ( >=app-doc/doxygen-1.2.16 )"

src_compile() {
	econf --enable-release || die "econf failed"

	emake || die "emake failed"

	use doc && ewarn "Attempting to build documentation"
	use doc && make doc || ewarn "Documentation was not built"
}

src_install () {
	einstall || die "einstall failed"

	use doc && dohtml ${S}/doc/doxygen/html/*

	cd ${S}
	dodoc AUTHORS INSTALL README NEWS
}
