# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/spectromatic/spectromatic-1.0.ebuild,v 1.3 2003/07/02 12:33:39 aliz Exp $

IUSE=""

MY_P="spectromatic_1.0-1"
DESCRIPTION="Little program that generates spectrograms (time-frequency analysis images) from mono or stereo wave files."
HOMEPAGE="http://ieee.uow.edu.au/~daniel/software/spectromatic/"
SRC_URI="http://ieee.uow.edu.au/~daniel/software/spectromatic/dist/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-libs/gsl-1.2
		>=media-libs/libpng-1.2.4"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die
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
