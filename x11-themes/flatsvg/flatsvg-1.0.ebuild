# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/flatsvg/flatsvg-1.0.ebuild,v 1.3 2006/01/11 19:59:34 gustavoz Exp $

inherit kde
need-kde 3.3

DESCRIPTION="Flat SVG icon set"
SRC_URI="http://www.atqu23.dsl.pipex.com/danny/flatSVG${PV}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=17158"

KEYWORDS="~sparc x86"
LICENSE="LGPL-2"

SLOT="0"
IUSE=""

S="${WORKDIR}/FlatSVG"

src_compile() {
	einfo "Nothing to compile..."
}

src_install(){
	cd ${S}
	dodir ${PREFIX}/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons/FlatSVG
}
