# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/aquafont/aquafont-2.7-r2.ebuild,v 1.5 2004/08/30 03:07:11 tgall Exp $

inherit font

IUSE="X"
MY_P="${PN/font/}${PV/\./_}"

DESCRIPTION="Handwritten Japanese fixed-width TrueType font"
HOMEPAGE="http://aquablue.milkcafe.to/"
SRC_URI="http://aquablue.milkcafe.to/fnt/${MY_P}.lzh"

KEYWORDS="x86 alpha sparc ~ppc ~amd64 ppc64"
LICENSE="aquafont"
SLOT=0

S="${WORKDIR}/${MY_P}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

DEPEND="${RDEPEND}
	app-arch/lha"
RDEPEND="X? ( virtual/x11 )"

DOCS="readme.txt"

src_unpack(){

	lha e ${DISTDIR}/${MY_P}.lzh
}
