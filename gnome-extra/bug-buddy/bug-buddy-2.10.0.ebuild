# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/bug-buddy/bug-buddy-2.10.0.ebuild,v 1.18 2006/09/05 02:43:58 kumba Exp $

inherit gnome2 eutils

DESCRIPTION="Bug Report helper for Gnome"
HOMEPAGE="http://www.gnome.org/"

LICENSE="Ximian-logos GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=dev-libs/libxml2-2.4.6
	>=gnome-base/gnome-vfs-2
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.3.6
	>=gnome-base/gnome-desktop-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libgnomeui-2.5.92
	>=gnome-base/gnome-menus-2.9.1
	>=app-text/gnome-doc-utils-0.1.3
	>=sys-devel/gdb-5.1
	>=sys-devel/gettext-0.10.40"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.8"

DOCS="AUTHORS ChangeLog README NEWS TODO"
USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnome2_omf_fix gnome-doc-utils.make docs/Makefile.in
	epatch ${FILESDIR}/${P}-fbsd.patch
}
