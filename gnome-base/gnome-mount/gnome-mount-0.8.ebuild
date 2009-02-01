# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mount/gnome-mount-0.8.ebuild,v 1.3 2009/02/01 12:10:27 maekke Exp $

inherit eutils gnome2

DESCRIPTION="Wrapper for (un)mounting and ejecting disks"
HOMEPAGE="http://hal.freedesktop.org/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="nautilus kernel_FreeBSD"

# FIXME: libnotify is automagic
RDEPEND=">=dev-libs/glib-2.15.0
	>=x11-libs/gtk+-2.8
	>=sys-apps/hal-0.5.8.1
	>=gnome-base/gnome-keyring-2.20
	>=gnome-base/gconf-2
	>=x11-libs/libnotify-0.3
	nautilus? (
		>=gnome-base/libglade-2
		>=gnome-base/nautilus-2.21.2 )
	>=dev-libs/dbus-glib-0.71"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.5"

DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable nautilus nautilus-extension)"
}

src_unpack() {
	gnome2_src_unpack

	use kernel_FreeBSD && epatch "${FILESDIR}/${PN}-0.6-freebsd-schemas.patch"

	# Include missing locale.h, bug #176035
	epatch "${FILESDIR}/${PN}-0.6-include-locale-h.patch"
}
