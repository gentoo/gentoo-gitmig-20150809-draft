# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/harminv/harminv-1.3.1.ebuild,v 1.2 2008/11/08 19:04:12 maekke Exp $

inherit eutils autotools

DESCRIPTION="Extraction of complex frequencies and amplitudes from time series"
HOMEPAGE="http://ab-initio.mit.edu/harminv/"
SRC_URI="http://ab-initio.mit.edu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/lapack"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.ac.patch
	eautoreconf
}

src_compile() {
	econf \
		--with-blas="$(pkg-config --libs blas)" \
		--with-lapack="$(pkg-config --libs lapack)" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README || die "dodoc failed"
}
