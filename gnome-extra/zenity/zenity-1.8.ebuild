# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zenity/zenity-1.8.ebuild,v 1.8 2004/03/23 20:44:26 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="commandline dialog tool for gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa ~amd64 ia64 ~mips"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=gnome-base/libgnomecanvas-2
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	app-text/scrollkeeper
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README THANKS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Don't set the UTF-8 codeset before parsing command line arguments.
	# Closes bug #45204.
	epatch ${FILESDIR}/${P}-utf8_fix.patch
}
