# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-volume-manager/gnome-volume-manager-1.0.2.ebuild,v 1.1 2004/09/16 13:00:59 foser Exp $

inherit gnome2

DESCRIPTION="Daemon that enforces volume-related policies"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

# we just require the latest of the utopia stack to be on the safe side
RDEPEND=">=sys-apps/dbus-0.22
	>=sys-apps/hal-0.2.97
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog COPYING README HACKING NEWS TODO"

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "To start the gnome-volume-manager daemon you need to configure"
	einfo "it through it's preferences capplet. Also the HAL daemon (hald)"
	einfo "needs to be running or it will shut down."

}
