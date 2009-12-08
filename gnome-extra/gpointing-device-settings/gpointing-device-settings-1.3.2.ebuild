# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gpointing-device-settings/gpointing-device-settings-1.3.2.ebuild,v 1.4 2009/12/08 18:10:16 pva Exp $

GCONF_DEBUG="no"
inherit eutils gnome2

DESCRIPTION="A GTK+ based configuration utility for the synaptics driver"
HOMEPAGE="http://gsynaptics.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/gsynaptics/43803/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# recent enough x11-base/xorg-server required
RDEPEND=">=dev-libs/glib-2.10
	>=x11-libs/gtk+-2.14.0
	>=gnome-base/gconf-2.24
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
