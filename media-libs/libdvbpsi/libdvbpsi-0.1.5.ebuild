# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvbpsi/libdvbpsi-0.1.5.ebuild,v 1.4 2006/11/03 14:38:03 gustavoz Exp $

IUSE="doc"

MY_P=${PN}4-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="library for MPEG TS/DVB PSI tables decoding and generation"
HOMEPAGE="http://www.videolan.org/libdvbpsi"
SRC_URI="http://download.videolan.org/pub/${PN}/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# doxygen missing: ~ia64
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 sparc ~x86"

DEPEND="doc? (
		>=app-doc/doxygen-1.2.16
		media-gfx/graphviz
	)"
RDEPEND=""

src_compile() {
	econf --enable-release || die "econf failed"

	emake || die "emake failed"

	if use doc; then
		ewarn "Attempting to build documentation"
		make doc || die "Could not build documentation."
	else
		ewarn "Documentation was not built"
	fi
}

src_install () {
	einstall || die "einstall failed"

	use doc && dohtml ${S}/doc/doxygen/html/*

	cd ${S}
	dodoc AUTHORS INSTALL README NEWS
}
