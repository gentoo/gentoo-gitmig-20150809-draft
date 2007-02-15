# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-session/rox-session-0.27-r1.ebuild,v 1.7 2007/02/15 02:51:41 lack Exp $

# ROX-Session-0.27 now is compatible with dbus >=0.3
# This version is all python, no more compiling

ROX_LIB_VER="2.0.0"
inherit eutils rox

DESCRIPTION="Rox-Session is a really simple session manager"
HOMEPAGE="http://rox.sourceforge.net/rox_session.html"
SRC_URI="mirror://sourceforge/rox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="<dev-python/dbus-python-0.80"

MY_PN="ROX-Session"
APPNAME=${MY_PN}

pkg_preinst() {
	# need to fixup some permissions
	cd ${D}/usr/lib/rox/${APPNAME}
	chmod 0755 browser Login RunROX SetupPanel
}

pkg_postinst() {
	echo
	einfo "ROX-Session has been installed into /usr/lib/rox/${APPNAME}."
	einfo "Please review its documentation about proper use. A symlink"
	einfo "for the executable has been created as /usr/bin/${APPNAME}."
}

