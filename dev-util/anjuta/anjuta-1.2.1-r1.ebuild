# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/anjuta/anjuta-1.2.1-r1.ebuild,v 1.1 2004/04/08 20:04:41 lisa Exp $

inherit eutils gnome2

DESCRIPTION="A versatile IDE for GNOME"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://anjuta.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
# Future versions will work with 64-bit archs, but 1.2.0 doesn't
KEYWORDS="~x86 ~ppc sparc ~amd64"

RDEPEND=">=dev-libs/glib-2.0.6
	>=x11-libs/gtk+-2.0.8
	>=gnome-base/ORBit2-2.4
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

DOCS="AUTHORS COPYING ChangeLog FUTURE NEWS README THANKS TODO"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}

	cd ${S}
#	epatch ${FILESDIR}/${P}_xim.patch
	epatch ${FILESDIR}/anjuta-1.2.1.fix.cmp.usage.diff.gz
	epatch ${FILESDIR}/anjuta-1.2.1.pass.proper.aclocal.args.diff.gz
}

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "Some project templates may require additional development"
	einfo "libraries to function correctly. It goes beyond the scope"
	einfo "of this ebuild to provide them."

}
