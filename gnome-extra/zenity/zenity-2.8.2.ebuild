# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zenity/zenity-2.8.2.ebuild,v 1.6 2005/03/20 17:49:04 kloeri Exp $

inherit gnome2 eutils

DESCRIPTION="commandline dialog tool for gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc ~hppa ~amd64 ~ia64 ~mips"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/libglade-2
	>=gnome-base/libgnomecanvas-2
	dev-libs/popt"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	app-text/scrollkeeper
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"

src_unpack() {

	unpack ${A}
	cd ${S}
	# Don't set the UTF-8 codeset before parsing command line arguments.
	# Closes bug #45204.
	epatch ${FILESDIR}/${PN}-2.6.3-utf8_fix.patch

}
