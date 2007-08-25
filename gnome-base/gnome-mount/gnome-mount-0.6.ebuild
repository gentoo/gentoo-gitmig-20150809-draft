# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mount/gnome-mount-0.6.ebuild,v 1.10 2007/08/25 14:24:54 vapier Exp $

inherit eutils gnome2

DESCRIPTION="Wrapper for (un)mounting and ejecting disks"
HOMEPAGE="http://freedesktop.org/~david/"
SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ~ppc64 sh sparc x86 ~x86-fbsd"
IUSE="debug gnome kernel_FreeBSD"

RDEPEND=">=gnome-base/libgnomeui-2.13
	>=sys-apps/hal-0.5.8.1
	>=x11-libs/gtk+-2.8
	gnome-base/gnome-keyring
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	x11-libs/libnotify
	gnome? (
		>=gnome-base/nautilus-2.5
		>=gnome-base/eel-2.5
		)
	>=dev-libs/dbus-glib-0.71"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README TODO"

pkg_setup() {
	G2CONF="$(use_enable gnome nautilus_extension)"
}

src_unpack() {
	gnome2_src_unpack

	use kernel_FreeBSD && epatch "${FILESDIR}/${P}"-freebsd-schemas.patch
	epatch "${FILESDIR}/${PN}-0.6-include-locale-h.patch"
}
