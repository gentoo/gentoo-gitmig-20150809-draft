# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/commonbox-utils/commonbox-utils-0.2.ebuild,v 1.2 2002/08/26 11:16:51 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Common utilities for flux|black|open(box). Provides bsetroot, bsetbg, and commonbox-menugen."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://mkeadle.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

RDEPEND="virtual/x11"

src_compile() {

	./install.sh

}

src_install () {

	dobin ${S}/util/bsetbg ${S}/util/bsetroot ${S}/util/commonbox-menugen
	dodoc README.commonbox-utils AUTHORS COPYING
	doman bsetroot.1 bsetbg.1
	
	dodir /usr/share/commonbox
	${D}/usr/bin/commonbox-menugen -kg -o ${D}/usr/share/commonbox/menu
}


pkg_postinst() {

	commonbox-menugen -kg
}
