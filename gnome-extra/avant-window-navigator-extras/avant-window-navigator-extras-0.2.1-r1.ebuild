# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator-extras/avant-window-navigator-extras-0.2.1-r1.ebuild,v 1.1 2007/12/06 17:42:36 wltjr Exp $

inherit gnome2

MY_P="awn-extras-applets-${PV}"
DESCRIPTION="Applets for the avant-window-navigator"
HOMEPAGE="http://launchpad.net/awn-extras"
SRC_URI="http://launchpad.net/awn-extras/${PV}/${PV}/+download/awn-extras-applets-${PV}.tar"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyalsaaudio
	gnome-base/gnome-menus
	gnome-base/librsvg
	gnome-base/libgtop
	gnome-extra/avant-window-navigator
	net-libs/libgmail
	x11-libs/libsexy
	x11-libs/libnotify"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	gnome2_src_install
	mv "${D}/etc/gconf/schemas/notification-daemon.schemas" \
		"${D}/etc/gconf/schemas/awn-notification-daemon.schemas"
	mv "${D}/etc/gconf/schemas/awnsystemmonitor.schemas" \
		"${D}/etc/gconf/schemas/awn-system-monitor.schemas"
	mv "${D}/etc/gconf/schemas/filebrowser.schemas" \
		"${D}/etc/gconf/schemas/awn-filebrowser.schemas"
	mv "${D}/etc/gconf/schemas/switcher.schemas" \
		"${D}/etc/gconf/schemas/awn-switcher.schemas"
	mv "${D}/etc/gconf/schemas/trash.schemas" \
		"${D}/etc/gconf/schemas/awn-trash.schemas"
}
