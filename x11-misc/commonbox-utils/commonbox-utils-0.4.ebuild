# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header

S=${WORKDIR}/${P}
DESCRIPTION="Common utilities for fluxbox, blackbox, and openbox"
#SRC_URI="mirror://gentoo/${P}.tar.bz2"
SRC_URI="http://mkeadle.org/distfiles/${P}.tar.bz2"
HOMEPAGE="http://mkeadle.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa"

DEPENDS="media-gfx/xv"

RDEPEND="virtual/x11"

src_compile() {

	cd ${S}
	./compile.sh

}

src_install () {

	dobin ${S}/util/bsetbg ${S}/util/bsetroot ${S}/util/commonbox-menugen ${S}/util/commonbox-imagebgmenugen
	dodoc README.commonbox-utils AUTHORS COPYING
	doman bsetroot.1 bsetbg.1
	
	insinto /usr/share/commonbox
	doins ${S}/solidbgmenu
}


pkg_postinst() {

	commonbox-imagebgmenugen
	commonbox-menugen -kg -o /usr/share/commonbox/menu

}
