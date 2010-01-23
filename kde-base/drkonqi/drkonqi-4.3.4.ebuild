# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/drkonqi/drkonqi-4.3.4.ebuild,v 1.3 2010/01/23 17:40:41 armin76 Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE crash handler, gives the user feedback if a program crashed"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

add_blocker drkonqi2

pkg_postinst() {
	kde4-meta_pkg_postinst
	elog "For more usability consider installing folowing packages:"
	elog "    sys-devel/gdb - Easier debugging support"
}
