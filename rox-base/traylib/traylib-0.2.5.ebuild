# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/traylib/traylib-0.2.5.ebuild,v 1.1 2007/11/26 13:33:56 lack Exp $

NEED_PYTHON="2.3"
inherit python eutils multilib

MY_PN="TrayLib"
DESCRIPTION="TrayLib is a library for tray-based rox panel applets."
HOMEPAGE="http://rox4debian.berlios.de"
SRC_URI="ftp://ftp.berlios.de/pub/rox4debian/libs/${MY_PN}-${PV}.tgz"

RDEPEND=">=rox-base/rox-lib-1.9.6"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

src_install() {
	local baselibdir="/usr/$(get_libdir)"
	dodir "${baselibdir}"
	cp -r ${MY_PN}/ "${D}${baselibdir}/${MY_PN}"
	python_mod_optimize "${D}${baselibdir}/${MY_PN}/" >/dev/null 2>&1
	dodir /usr/share/doc/
	dosym ${baselibdir}/${MY_PN}/Help /usr/share/doc/${P}
}
