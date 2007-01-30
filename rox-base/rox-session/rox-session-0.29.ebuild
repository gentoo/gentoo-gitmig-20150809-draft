# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-session/rox-session-0.29.ebuild,v 1.2 2007/01/30 17:53:05 lack Exp $

ROX_LIB_VER="2.0.0"
inherit eutils rox

DESCRIPTION="Rox-Session is a really simple session manager"
HOMEPAGE="http://rox.sourceforge.net/rox_session.html"
SRC_URI="mirror://sourceforge/rox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( >=dev-python/dbus-python-0.71
		( >=sys-apps/dbus-0.3 <sys-apps/dbus-0.90 ) )"

MY_PN="ROX-Session"
APPNAME=${MY_PN}

pkg_setup() {
	if ! has_version dev-python/dbus-python && \
		! built_with_use sys-apps/dbus python
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

src_install() {
	rox_src_install

	dobin "${FILESDIR}/rox-start"

	local wm="rox"
	make_session_desktop "ROX Desktop" /usr/bin/rox-start

	dodir /etc/X11/Sessions
	echo "/usr/bin/rox-start" > "${D}/etc/X11/Sessions/ROX_Desktop"
	fperms a+x /etc/X11/Sessions/ROX_Desktop
}

pkg_postinst() {
	echo
	einfo "ROX-Session has been installed into /usr/lib/rox/${APPNAME}."
	einfo "Please review its documentation about proper use. A symlink"
	einfo "for the executable has been created as /usr/bin/${APPNAME}."
	echo
	einfo "It has also been installed as an X Session, so you should be"
	einfo "able to select it in the Session list of gdm or kdm"
}

