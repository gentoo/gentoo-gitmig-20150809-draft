# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gpdf/gpdf-0.112.ebuild,v 1.3 2004/02/10 06:26:22 darkspecter Exp $

inherit gnome2 flag-o-matic eutils

DESCRIPTION="your favourite pdf previewer"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~alpha ~sparc ~hppa ~amd64 ~ia64"
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

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-remove_gtk24_call.patch

}

src_compile() {
	use alpha && append-flags -fPIC
	gnome2_src_compile
}
