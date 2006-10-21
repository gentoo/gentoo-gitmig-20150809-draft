# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-mount/gnome-mount-0.4-r5.ebuild,v 1.3 2006/10/21 23:43:43 kloeri Exp $

inherit eutils gnome2

DESCRIPTION="Wrapper for (un)mounting and ejecting disks"
HOMEPAGE="http://freedesktop.org/~david/"
SRC_URI="http://freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="debug"

RDEPEND=">=gnome-base/libgnomeui-2.13
	>=sys-apps/dbus-0.60
	>=sys-apps/hal-0.5.7-r1
	>=x11-libs/gtk+-2.8
	gnome-base/gnome-keyring
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README TODO"

src_unpack() {
	gnome2_src_unpack

	# fixes for bug #133549, bug #133880, bug #137211
	epatch "${FILESDIR}"/${PN}-hal-no-media-fstab.patch

	# add support for mounting with ntfs-3g
	epatch "${FILESDIR}"/${P}-ntfs3g.patch
}
