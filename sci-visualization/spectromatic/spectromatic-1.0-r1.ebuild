# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/spectromatic/spectromatic-1.0-r1.ebuild,v 1.3 2010/06/23 20:19:42 bicatali Exp $

inherit eutils

MY_P="spectromatic_1.0-1"

DESCRIPTION="Generates time-frequency analysis images from wav files"
HOMEPAGE="http://ieee.uow.edu.au/~daniel/software/spectromatic/"
SRC_URI="http://ieee.uow.edu.au/~daniel/software/spectromatic/dist/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libpng
	sci-libs/gsl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-stringliteral.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README
}
