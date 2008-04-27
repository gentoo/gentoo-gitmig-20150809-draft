# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/octave-forge/octave-forge-2006.03.17-r1.ebuild,v 1.6 2008/04/27 15:09:40 markusle Exp $

inherit eutils

DESCRIPTION="A collection of custom scripts, functions and extensions for GNU Octave"
HOMEPAGE="http://octave.sourceforge.net/"
SRC_URI="mirror://sourceforge/octave/${P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE="ginac qhull X"

DEPEND=">=sci-mathematics/octave-2.1.72
		sci-libs/netcdf
		media-libs/jpeg
		media-libs/libpng
		sci-libs/gsl
		dev-libs/libpcre
		sys-libs/readline
		sys-apps/texinfo
		sys-libs/ncurses
		virtual/lapack
		virtual/blas
		sci-calculators/units
		X? ( x11-libs/libX11 )
		!amd64? ( ginac? ( sci-mathematics/ginac ) )
		qhull? ( >=media-libs/qhull-3.1-r1 )"

src_unpack() {
	cd "${S}"
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-config-fix.patch
	epatch "${FILESDIR}"/${P}-imagemagick.patch
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf $(use_with X x) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS COPYING* ChangeLog RELEASE-NOTES TODO
}

pkg_postinst() {
	einfo "If you do not have GiNaC and Qhull installed, octave-forge did not"
	einfo "compile itself with support for the geometry and symbolic math"
	einfo "extensions. If you would like these features, please emerge ginac"
	einfo "and/or qhull and then re-emerge octave-forge. Alternately, you can"
	einfo "specify USE='ginac qhull' and re-emerge octave-forge; in that case"
	einfo "the ebuild will automatically install the additional packages."
}
