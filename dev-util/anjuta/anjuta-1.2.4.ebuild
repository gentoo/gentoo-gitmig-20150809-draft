# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/anjuta/anjuta-1.2.4.ebuild,v 1.2 2005/08/19 11:49:11 weeve Exp $

inherit eutils gnome2

DESCRIPTION="A versatile IDE for GNOME"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://anjuta.sourceforge.net/"

IUSE="doc"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND=">=dev-libs/glib-2.0.6
	>=x11-libs/gtk+-2.0.8
	>=gnome-base/orbit-2.10.3
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.0.2
	>=gnome-base/libgnomeui-2.0.2
	>=gnome-base/libgnomeprint-2.0.1
	>=gnome-base/libgnomeprintui-2.0.1
	>=gnome-base/gnome-vfs-2.0.2
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2.0.1
	>=x11-libs/vte-0.9
	>=dev-libs/libxml2-2.4.23
	>=x11-libs/pango-1.1.1
	dev-libs/libpcre
	app-text/scrollkeeper"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog FUTURE NEWS README THANKS TODO "

MAKEOPTS="${MAKEOPTS} -j1"

pkg_postinst() {

	gnome2_pkg_postinst

	if use doc; then
		dodoc ${S}/manuals
		dodoc ${S}/doc
	fi

	einfo
	einfo "Some project templates may require additional development"
	einfo "libraries to function correctly. It goes beyond the scope"
	einfo "of this ebuild to provide them."
	einfo

	ewarn "If code autocompletion is missing gtk+ and other pkg-config"
	ewarn "managed package headers, resolve any errors produced by the"
	ewarn "following command, and then re-emerge anjuta:"
	ewarn
	ewarn "# pkg-config --cflags \`pkg-config --list-all 2>/dev/null | awk '{printf(\"%s \",\$1);}'\`"
	ewarn
}
