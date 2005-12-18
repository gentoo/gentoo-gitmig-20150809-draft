# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/flatsvg/flatsvg-1.0.ebuild,v 1.2 2005/12/18 13:33:48 nelchael Exp $

inherit kde
need-kde 3.3

DESCRIPTION="Flat SVG icon set"
SRC_URI="http://www.atqu23.dsl.pipex.com/danny/flatSVG${PV}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=17158"

KEYWORDS="x86"
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
