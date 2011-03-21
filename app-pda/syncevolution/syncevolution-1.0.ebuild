# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/syncevolution/syncevolution-1.0.ebuild,v 1.3 2011/03/21 21:56:01 nirbheek Exp $

EAPI=2

inherit gnome2

DESCRIPTION="A SyncML desktop client and server"
HOMEPAGE="http://syncevolution.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite +gtk +eds bluetooth +gnome"

SRC_URI="http://downloads.syncevolution.org/syncevolution/sources/${P}.tar.gz"

RDEPEND=">=gnome-base/gconf-2:2
	>=dev-libs/glib-2.16:2
	>=net-libs/libsoup-2.4:2.4
	>=sys-apps/dbus-1.2
	x11-libs/libnotify
	>=gnome-base/gnome-keyring-2.20
	gtk? ( >=x11-libs/gtk+-2.18:2
		dev-libs/libunique:1 )
	eds? ( >=gnome-extra/evolution-data-server-1.2
		>=dev-libs/libical-0.43 )
	bluetooth? (
		>=net-wireless/bluez-4
		>=dev-libs/openobex-1.5
		gnome? ( >=net-wireless/gnome-bluetooth-2.28 ) )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-python/docutils
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.37.1"

DOCS="README NEWS AUTHORS HACKING"

pkg_setup() {
	G2CONF="--with-rst2man=/usr/bin/rst2man.py
		--with-rst2html=/usr/bin/rst2html.py
		--enable-dbus-service
		$(use_enable bluetooth)
		$(use_enable sqlite)
		$(use_enable eds ebook)
		$(use_enable eds ecal)"
	if use bluetooth; then
		G2CONF="${G2CONF}
			$(use_enable gnome gnome-bluetooth-panel-plugin)"
	else
		G2CONF="${G2CONF} --disable-gnome-bluetooth-panel-plugin"
	fi
	if use gtk; then
		G2CONF="${G2CONF} --enable-gui=gtk"
	else
		G2CONF="${G2CONF} --enable-gui=no"
	fi
}
