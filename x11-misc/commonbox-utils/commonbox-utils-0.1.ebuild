# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/commonbox-utils/commonbox-utils-0.1.ebuild,v 1.5 2002/10/04 06:42:40 vapier Exp $

S=${WORKDIR}
DESCRIPTION="Common utilities for flux|black|open(box). Provides bsetroot, bsetbg, and commonbox-menugen."
SRC_URI="http://mkeadle.org/ebuilds/${P}.tar.bz2"
HOMEPAGE="http://mkeadle.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11"

src_compile() {

	./install.sh

}

src_install () {

	dobin ${S}/util/bsetbg ${S}/util/bsetroot ${S}/util/commonbox-menugen
	dodoc README.commonbox-utils AUTHORS COPYING
	doman bsetroot.1 bsetbg.1
	
	dodir /usr/share/commonbox
	commonbox-menugen -kg -o ${D}/usr/share/commonbox/menu
}


pkg_postinst() {

	commonbox-menugen -kg
}
