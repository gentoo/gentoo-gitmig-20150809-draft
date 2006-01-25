# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/peacock/peacock-1.9.1.ebuild,v 1.7 2006/01/25 11:31:36 nattfodd Exp $

IUSE=""

DESCRIPTION="A simple GTK HTML editor"
SRC_URI="mirror://sourceforge/peacock/${P}.tar.gz"
HOMEPAGE="http://peacock.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"

DEPEND="dev-util/pkgconfig
	>=x11-libs/gtksourceview-0.5
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonoboui-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libgnome-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/gconf-2
	>=gnome-base/orbit-2
	>=gnome-base/libgnomeprint-2
	>=dev-libs/glib-2
	gnome-base/gnome-keyring
	x11-libs/pango
	dev-libs/atk
	media-libs/libart_lgpl
	dev-libs/libxml2"

src_compile() {

	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}
