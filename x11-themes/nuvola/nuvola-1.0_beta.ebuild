# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/nuvola/nuvola-1.0_beta.ebuild,v 1.1 2004/04/30 20:50:35 centic Exp $

inherit kde
need-kde 3

MY_P="${P/_beta/beta}"

DESCRIPTION="Nuvola SVG evolution of SKY icon theme."
SRC_URI="http://www.icon-king.com/files/${MY_P}.tgz"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5358"

KEYWORDS="~x86 ~alpha ~ppc ~sparc"
LICENSE="LGPL-2"

SLOT="0"
IUSE=""

RESTRICT="$RESTRICT nostrip"

S="${WORKDIR}/nuvola"

# necessary to avoid normal compilation steps, we have nothing to compile here
src_compile() {
	unpack ${MY_P}.tgz
	cd ${S}
}

src_install(){
	cd ${S}
	dodir $PREFIX/share/icons/
	cp -rf ${S} ${D}/${PREFIX}/share/icons/Nuvola-${PV}
}

