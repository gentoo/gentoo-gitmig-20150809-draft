# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.10.1-r1.ebuild,v 1.8 2005/08/25 23:54:25 agriffis Exp $

inherit eutils gnome2

DESCRIPTION="Utilities for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ~mips ppc ~ppc64 sparc x86"
IUSE="ipv6 hal"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libgnome-2.5
	>=gnome-base/libgnomeui-2.5
	>=gnome-base/gnome-desktop-2.9.91
	>=gnome-base/libglade-2.3
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/gnome-vfs-2.8.4
	>=gnome-base/gnome-panel-2.9.4
	>=gnome-base/libgnomeprint-2.8
	>=gnome-base/libgnomeprintui-2.8
	>=gnome-base/gconf-1.2.1
	sys-fs/e2fsprogs
	dev-libs/popt
	hal? ( >=sys-apps/hal-0.4 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable hal)"

DOCS="AUTHORS ChangeLog NEWS README THANKS"

src_unpack() {

	unpack ${A}
	cd ${S}
	# fix gfloppy compile problem
	#epatch ${FILESDIR}/${PN}-2.9-gfloppymajor.patch
	# may need more work
	epatch ${FILESDIR}/${P}-gdict_pref.patch

}

USE_DESTDIR="1"
