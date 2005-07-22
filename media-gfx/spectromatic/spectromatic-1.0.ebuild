# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/spectromatic/spectromatic-1.0.ebuild,v 1.3 2005/07/22 18:12:13 dholm Exp $

inherit eutils

IUSE=""

MY_P="spectromatic_1.0-1"
DESCRIPTION="Little program that generates spectrograms (time-frequency analysis images) from mono or stereo wave files."
HOMEPAGE="http://ieee.uow.edu.au/~daniel/software/spectromatic/"
SRC_URI="http://ieee.uow.edu.au/~daniel/software/spectromatic/dist/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"

DEPEND=">=sci-libs/gsl-1.2
		>=media-libs/libpng-1.2.4"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-stringliteral.patch
}
src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dobin spectromatic
	doman spectromatic.1
	dodoc COPYING README || die
}
