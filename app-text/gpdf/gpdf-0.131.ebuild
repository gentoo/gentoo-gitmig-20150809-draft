# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gpdf/gpdf-0.131.ebuild,v 1.10 2004/10/25 07:32:56 usata Exp $

inherit gnome2 flag-o-matic

DESCRIPTION="A viewer for Portable Document Format (PDF) files"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="x86 ppc alpha ~sparc hppa amd64 ~ia64 mips"

RDEPEND=">=x11-libs/gtk+-2.3
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2.2.1
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeprint-2.6
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

PROVIDE="virtual/pdfviewer"

DOCS="AUTHORS CHANGES ChangeLog COPYING INSTALL NEWS README*"

src_compile() {

	use alpha && append-flags -fPIC
	gnome2_src_compile

}
