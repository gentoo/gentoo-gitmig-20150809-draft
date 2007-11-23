# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mount/gnome-mount-0.7.ebuild,v 1.1 2007/11/23 20:54:54 compnerd Exp $

inherit eutils gnome2

DESCRIPTION="HAL wrapper for (un)mounting and ejecting disks"
HOMEPAGE="http://hal.freedesktop.org/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nautilus"

RDEPEND=">=x11-libs/gtk+-2.8
		 >=gnome-base/gconf-2
		 >=gnome-base/gnome-keyring-0.4.0
		 >=sys-apps/hal-0.5.8.1
		 >=dev-libs/dbus-glib-0.71
		 >=x11-libs/libnotify-0.3.0
		 >=sys-auth/policykit-0.6
		   gnome-extra/policykit-gnome
		 nautilus?	(
						>=gnome-base/libgnomeui-2.14
						>=gnome-base/libglade-2
						>=gnome-base/nautilus-2.5
						>=gnome-base/eel-2.5
					)"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		  dev-util/pkgconfig
		>=dev-util/intltool-0.35.0"

DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README TODO"

pkg_setup() {
	G2CONF="$(use_enable nautilus nautilus_extension)"
}
