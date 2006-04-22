# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gpdf/gpdf-0.132-r1.ebuild,v 1.8 2006/04/22 22:13:15 carlo Exp $

inherit gnome2 flag-o-matic eutils

DESCRIPTION="Viewer for Portable Document Format (PDF) files"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa ~amd64 ia64 mips"
IUSE=""

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
	app-text/scrollkeeper
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"



DOCS="AUTHORS CHANGES ChangeLog COPYING INSTALL NEWS README*"

src_unpack() {

	unpack ${A}

	cd ${S}/xpdf
	# fix security vulnerability (#68571)
	epatch ${FILESDIR}/${PN}-xpdf_2_CAN-2004-0888.patch

}
