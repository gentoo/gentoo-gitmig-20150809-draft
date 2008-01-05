# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtranslator/gtranslator-1.1.6-r1.ebuild,v 1.3 2008/01/05 17:14:30 nixnut Exp $

inherit gnome2 eutils

DESCRIPTION="An enhanced gettext po file editor for GNOME"
HOMEPAGE="http://gtranslator.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtranslator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

RDEPEND=">=dev-libs/libxml2-2.4.12
	app-text/gtkspell
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.1.4
	>=dev-util/intltool-0.22
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README THANKS TODO"

src_unpack() {
	gnome2_src_unpack

	# Fix path (bug #165187)
	epatch "${FILESDIR}"/${P}-defines.patch

	# Fix scrollkeeper detection
	epatch "${FILESDIR}"/${P}-scrollkeeper.patch
}
