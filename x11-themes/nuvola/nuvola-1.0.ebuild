# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/nuvola/nuvola-1.0.ebuild,v 1.1 2004/11/11 23:39:17 centic Exp $

inherit kde
need-kde 3

DESCRIPTION="Nuvola SVG evolution of SKY icon theme."
SRC_URI="http://www.icon-king.com/files/${P}.tar.gz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5358"

KEYWORDS="~x86 ~alpha ~ppc ~sparc ~amd64"
LICENSE="LGPL-2"

SLOT="0"
IUSE=""

RESTRICT="$RESTRICT nostrip"

S="${WORKDIR}/nuvola"

# necessary to avoid normal compilation steps, we have nothing to compile here
src_compile() {
	einfo "Nothing to compile..."
}

src_install(){
	cd ${S}
	dodir $PREFIX/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons/Nuvola-${PV}
}

