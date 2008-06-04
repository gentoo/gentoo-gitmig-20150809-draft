# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-lib/rox-lib-2.0.4.ebuild,v 1.6 2008/06/04 12:34:25 lack Exp $

NEED_PYTHON="2.3"
inherit python eutils multilib

MY_PN="rox-lib2"
DESCRIPTION="ROX-Lib2 - Shared code for ROX applications by Thomas Leonard"
HOMEPAGE="http://rox.sourceforge.net/desktop/ROX-Lib"
SRC_URI="mirror://sourceforge/rox/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND=">=rox-base/rox-2.2.0
		>=dev-python/pygtk-2.8.2"

S=${WORKDIR}/${MY_PN}-${PV}

src_install() {
	local baselibdir="/usr/$(get_libdir)"
	dodir ${baselibdir}
	cp -r ROX-Lib2/ "${D}${baselibdir}"
	dodir /usr/share/doc/
	dosym ${baselibdir}/ROX-Lib2/Help /usr/share/doc/${P}
}

pkg_postinst() {
	local baselibdir="/usr/$(get_libdir)"
	python_mod_optimize "${baselibdir}/ROX-Lib2/"
}

pkg_postrm() {
	python_mod_cleanup
}
