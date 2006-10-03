# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.31-r1.ebuild,v 1.3 2006/10/03 23:18:29 agriffis Exp $

inherit eutils gnome2 flag-o-matic

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"

#
# Please ensure that gcc-3.4 is stable on the arch before moving this to stable.
#
SRC_URI="${SRC_URI}
	http://archive.ubuntu.com/ubuntu/pool/main/g/gnome-cups-manager/gnome-cups-manager_0.31-1.1ubuntu14.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

# See ChangeLog regarding libgnomeui
RDEPEND=">=x11-libs/gtk+-2.3.1
	>=dev-libs/glib-2.3.1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.2.0
	gnome-base/gnome-keyring
	x11-libs/gksu"

DEPEND=">=x11-libs/gtk+-2.3.1
	>=dev-libs/glib-2.3.1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.2.0
	gnome-base/gnome-keyring

	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"

DOCS="ChangeLog NEWS README"

src_unpack() {
	gnome2_src_unpack
	cd ${S}
	epatch ${WORKDIR}/gnome-cups-manager_0.31-1.1ubuntu14.diff
	# gksudo does not always work
	sed -i "s:gksudo:gksu:" debian/patches/change-su-command.patch
	epatch debian/patches/*

	# bug 141929
	use amd64 && replace-flags -O* -O0
}

src_install() {
	gnome2_src_install
	cd debian
	doman gnome-cups-icon.1 gnome-cups-manager.1 gnome-cups-add.8
	domenu gnome-cups-icon.desktop gnome-cups-manager.desktop
}
