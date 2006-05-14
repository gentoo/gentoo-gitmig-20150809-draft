# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/kpowersave/kpowersave-0.6.1.ebuild,v 1.1 2006/05/14 21:41:58 genstef Exp $

inherit kde

DESCRIPTION="KDE front-end to powersave daemon"
HOMEPAGE="http://powersave.sf.net/"
SRC_URI="mirror://sourceforge/powersave/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=sys-apps/hal-0.5.4
	>=sys-apps/dbus-0.33
	>=sys-power/powersave-0.11.5
	kde-base/unsermake"

pkg_setup() {
	if ! built_with_use sys-apps/dbus qt; then
		eerror "dbus is missing qt support. Please add"
		eerror "'qt' to your USE flags, and re-emerge sys-apps/dbus."
		die "dbus needs qt support"
	fi

	set-kdedir
	UNSERMAKE="/usr/kde/unsermake/unsermake"
}
