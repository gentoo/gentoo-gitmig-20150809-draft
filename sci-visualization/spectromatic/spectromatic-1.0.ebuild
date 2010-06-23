# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/spectromatic/spectromatic-1.0.ebuild,v 1.4 2010/06/23 20:19:42 bicatali Exp $

inherit eutils

IUSE=""

MY_P="spectromatic_1.0-1"
DESCRIPTION="Generates spectrograms (time-frequency analysis images) from mono or stereo wave files."
HOMEPAGE="http://ieee.uow.edu.au/~daniel/software/spectromatic/"
SRC_URI="http://ieee.uow.edu.au/~daniel/software/spectromatic/dist/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=">=media-libs/libpng-1.2.4
	sci-libs/gsl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.diff
	epatch "${FILESDIR}"/${P}-stringliteral.patch
}
src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dobin spectromatic
	doman spectromatic.1
	dodoc README || die
}
