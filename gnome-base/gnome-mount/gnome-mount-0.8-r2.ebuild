# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mount/gnome-mount-0.8-r2.ebuild,v 1.4 2011/02/05 13:13:13 ssuominen Exp $

# This package is used by FreeBSD long as gnome-base/gvfs has USE hal. Linux has
# gnome-base/gvfs with USE gdu and udev.

EAPI=1
inherit autotools eutils gnome2

DESCRIPTION="Wrapper for (un)mounting and ejecting disks"
HOMEPAGE="http://hal.freedesktop.org/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE="nautilus kernel_FreeBSD"

RDEPEND=">=dev-libs/glib-2.15:2
	>=x11-libs/gtk+-2.8:2
	>=sys-apps/hal-0.5.8.1
	|| ( gnome-base/libgnome-keyring <gnome-base/gnome-keyring-2.29.4 )
	>=gnome-base/gconf-2
	nautilus? (
		>=gnome-base/libglade-2
		>=gnome-base/nautilus-2.21.2 )
	>=dev-libs/dbus-glib-0.88"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35.5"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --disable-static
		--disable-libnotify
		$(use_enable nautilus nautilus-extension)"
}

src_unpack() {
	gnome2_src_unpack

	use kernel_FreeBSD && epatch "${FILESDIR}/${PN}-0.6-freebsd-schemas.patch"

	# Include missing locale.h, bug #176035
	epatch "${FILESDIR}/${PN}-0.6-include-locale-h.patch"

	# Better defaults for vfat, bug #257745
	use kernel_FreeBSD || epatch "${FILESDIR}/${P}-vfat-defaults.patch"

	# Fix HAL locking for devices in fstab, bug #257746
	epatch "${FILESDIR}/${P}-fstablock.patch"

	# Fix automagic dependency, bug #257753
	epatch "${FILESDIR}/${P}-libnotify-automagic.patch"

	# locale option is no longer recognized by ntfs3g, upstream bug #624953
	epatch "${FILESDIR}/${P}-ntfs3g-locale.patch"

	eautoreconf
}
