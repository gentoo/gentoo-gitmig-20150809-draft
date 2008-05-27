# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtranslator/gtranslator-1.1.7.ebuild,v 1.1 2008/05/27 18:58:34 remi Exp $

inherit gnome2 eutils

DESCRIPTION="An enhanced gettext po file editor for GNOME"
HOMEPAGE="http://gtranslator.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
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

DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README THANKS TODO"

src_unpack() {
	gnome2_src_unpack

	# Fix scrollkeeper detection
	epatch "${FILESDIR}"/${PN}-1.1.7-scrollkeeper.patch
}
