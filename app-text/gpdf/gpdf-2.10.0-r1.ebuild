# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gpdf/gpdf-2.10.0-r1.ebuild,v 1.9 2006/04/22 22:13:15 carlo Exp $

inherit gnome2 eutils

DESCRIPTION="Viewer for Portable Document Format (PDF) files"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.5.4
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



DOCS="AUTHORS CHANGES ChangeLog NEWS README*"

USE_DESTDIR="1"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Fix sec vuln (#69662)
	epatch ${FILESDIR}/${PN}-xpdf_goo_sizet.patch
	# Fix building on amd64 with gcc4
	epatch ${FILESDIR}/${P}-amd64-gcc4.patch
	# Disable the tests, see bug #73882
	sed -i -e "s:test-files::" Makefile.in
	# Fix for bug #100265
	epatch ${FILESDIR}/${PN}-2.8.2-CAN-2005-2097.patch
}

src_install() {

	# fix #92920 FIXME
	gnome2_src_install scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/

}

