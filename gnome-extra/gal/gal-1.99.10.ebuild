# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal/gal-1.99.10.ebuild,v 1.10 2004/02/11 01:30:05 vapier Exp $

inherit gnome2 gnome.org libtool

DESCRIPTION="The Gnome Application Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ppc sparc hppa alpha ia64 amd64"
IUSE="doc"

RDEPEND=">=gnome-base/libgnomeprint-2.2.0
	>=gnome-base/libgnomeprintui-2.2.1
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libgnomecanvas-2.2.0.2
	>=dev-libs/libxml2-2.0
	app-text/scrollkeeper"
DEPEND="sys-devel/gettext
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc )
	${RDEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"
USE_DESTDIR="1"
ELTCONF="--reverse-deps"

src_unpack() {
	unpack ${A}

	gnome2_omf_fix

	# Remove gtkdoc-fixxref
	cd ${S}; epatch ${FILESDIR}/gal-1.99.3-docfix.patch
}
