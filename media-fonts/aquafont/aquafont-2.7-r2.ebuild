# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/aquafont/aquafont-2.7-r2.ebuild,v 1.2 2004/07/14 17:00:31 agriffis Exp $

inherit font

IUSE="X"
MY_P="${PN/font/}${PV/\./_}"

DESCRIPTION="Very pretty Japanese truetype font"
HOMEPAGE="http://aquablue.milkcafe.to/"
SRC_URI="http://aquablue.milkcafe.to/fnt/${MY_P}.lzh"

KEYWORDS="~x86 ~alpha ~sparc ~ppc ~amd64"
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
