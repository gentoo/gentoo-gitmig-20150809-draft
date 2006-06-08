# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-lib/rox-lib-2.0.3.ebuild,v 1.1 2006/06/08 07:28:57 dragonheart Exp $

MY_PN="rox-lib2"
DESCRIPTION="ROX-Lib2 - Shared code for ROX applications by Thomas Leonard"
HOMEPAGE="http://rox.sourceforge.net/desktop/ROX-Lib"
SRC_URI="mirror://sourceforge/rox/${MY_PN}-${PV}.tar.bz2"

#compile rox python
inherit python

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=rox-base/rox-2.1.0
		>=dev-lang/python-2.2
		>=dev-python/pygtk-1.99.13"

S=${WORKDIR}/${MY_PN}-${PV}
src_install() {
	dodir /usr/lib/
	cp -r ROX-Lib2/ ${D}/usr/lib/
	python_mod_optimize ${D}/usr/lib/ROX-Lib2/ >/dev/null 2>&1
	dodir /usr/share/doc/
	dosym /usr/lib/ROX-Lib2/Help /usr/share/doc/${P}
}
