# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gpdf/gpdf-0.111.ebuild,v 1.6 2004/01/18 14:25:03 gustavoz Exp $

inherit gnome2 flag-o-matic

DESCRIPTION="your favourite pdf previewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc alpha sparc hppa ~amd64 ia64"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2.2.1
	>=gnome-base/libbonoboui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeprint-2.3
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libglade-2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS CHANGES ChangeLog COPYING INSTALL NEWS README*"

src_compile() {
	use alpha && append-flags -fPIC
	gnome2_src_compile
}
