# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-session/rox-session-0.27.ebuild,v 1.1 2006/04/16 13:04:46 svyatogor Exp $

# ROX-Session-0.27 now is compatible with dbus >=0.3
# This version is all python, no more compiling

inherit eutils

MY_PN="ROX-Session"
DESCRIPTION="Rox-Session is a really simple session manager"
HOMEPAGE="http://rox.sourceforge.net/rox_session.html"
SRC_URI="mirror://sourceforge/rox/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND=">=sys-apps/dbus-0.2"

APPNAME=${MY_PN}
S="${WORKDIR}/${PN}-${PV}"

inherit rox

pkg_setup() {
	if ! built_with_use sys-apps/dbus python
	then
		einfo "Rox-Session requires dbus to be built with python support."
		einfo "Please rebuild dbus with USE=\"python\"."
		die "python dbus modules missing"
	fi
}

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

