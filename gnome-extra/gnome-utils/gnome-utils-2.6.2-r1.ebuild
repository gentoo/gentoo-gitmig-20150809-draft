# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-utils/gnome-utils-2.6.2-r1.ebuild,v 1.1 2004/07/23 13:23:04 spider Exp $

inherit gnome2 eutils

DESCRIPTION="Utilities for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

IUSE="ipv6"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"

RDEPEND=">=x11-libs/gtk+-2.3.2
	>=gnome-base/libgnome-2.5
	>=gnome-base/libgnomeui-2.5
	>=gnome-base/gnome-desktop-2.2
	>=gnome-base/libglade-2.3
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/gnome-vfs-2.4
	>=gnome-base/gnome-panel-2.4
	>=gnome-base/gconf-1.2.1
	sys-fs/e2fsprogs
	dev-libs/popt"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_enable ipv6)"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix gfloppy compile problem
	epatch ${FILESDIR}/${P}-gfloppymajor.patch
}
