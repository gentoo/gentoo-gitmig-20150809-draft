# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/sylpheed-theme/sylpheed-theme-3.ebuild,v 1.1 2002/08/17 04:56:23 seemant Exp $

DESCRIPTION="Theme packs for sylpheed and sylpheed-claws and sylpheed-claws-nc"

HOMEPAGE="http://sylpheed-claws.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="virtual/sylpheed"

MY_P=${PN}-pak${PV}
SRC_URI="mirror://sourceforge/sylpheed-claws/${MY_P}.tar.bz2"

S=${WORKDIR}

src_compile() {

	einfo "Nothing to compile"
}

src_install () {

	dodoc README

	THEMEDIR=/usr/share/sylpheed/themes
	dodir ${THEMEDIR}
	
	rm README
	cp -a * ${D}/${THEMEDIR}

}
