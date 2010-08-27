# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/spectromatic/spectromatic-1.0-r2.ebuild,v 1.1 2010/08/27 07:21:51 xarthisius Exp $

EAPI=2

inherit base toolchain-funcs

MY_P=${PN}_${PV}-1

DESCRIPTION="Generates time-frequency analysis images from wav files"
HOMEPAGE="http://ieee.uow.edu.au/~daniel/software/spectromatic/"
SRC_URI="http://ieee.uow.edu.au/~daniel/software/spectromatic/dist/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libpng
	sci-libs/gsl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( README )
PATCHES=( "${FILESDIR}/${P}-makefile.patch"
	"${FILESDIR}/${P}-stringliteral.patch" )

pkg_setup() {
	tc-export CC
}
