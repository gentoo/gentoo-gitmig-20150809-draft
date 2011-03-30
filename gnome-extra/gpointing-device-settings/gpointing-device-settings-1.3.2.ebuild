# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gpointing-device-settings/gpointing-device-settings-1.3.2.ebuild,v 1.6 2011/03/30 11:09:42 angelos Exp $

GCONF_DEBUG="no"
EAPI=1
inherit eutils gnome2

DESCRIPTION="A GTK+ based configuration utility for the synaptics driver"
HOMEPAGE="http://live.gnome.org/GPointingDeviceSettings"
SRC_URI="mirror://sourceforge.jp/gsynaptics/43803/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# recent enough x11-base/xorg-server required
RDEPEND=">=dev-libs/glib-2.10:2
	>=x11-libs/gtk+-2.14.0:2
	>=gnome-base/gconf-2.24:2
	>=x11-libs/libXi-1.2
	!<=x11-base/xorg-server-1.6.0
	!gnome-extra/gsynaptics"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35.5"

DOCS="MAINTAINERS NEWS TODO"

src_install() {
	gnome2_src_install

	doicon data/touchpad.png
	make_desktop_entry gpointing-device-settings \
		gpointing-device-settings \
		touchpad \
		'GNOME;GTK;Settings;HardwareSettings'
}
