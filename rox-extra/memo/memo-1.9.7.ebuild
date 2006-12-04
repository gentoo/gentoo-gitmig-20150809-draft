# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/memo/memo-1.9.7.ebuild,v 1.3 2006/12/04 16:25:33 lack Exp $

ROX_LIB_VER=1.9.8
inherit rox

MY_PN="Memo"
DESCRIPTION="Memo - Memo is a simple alarm clock and clock applet for the ROX Desktop."
HOMEPAGE="http://rox.sourceforge.net/phpwiki/index.php/Memo"
SRC_URI="mirror://sourceforge/rox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="libnotify"

RDEPEND="libnotify? (
			|| ( >=dev-python/dbus-python-0.71
				( >=sys-apps/dbus-0.60 <sys-apps/dbus-0.90 ) )
			x11-misc/notification-daemon )"

APPNAME=${MY_PN}

pkg_setup() {
	if ! has_version dev-python/dbus-python && \
		! built_with_use sys-apps/dbus python
	then
		einfo "${APPNAME} requires dbus to be built with python support."
		einfo "Please rebuild dbus with USE=\"python\"."
		die "python dbus modules missing"
	fi
}

