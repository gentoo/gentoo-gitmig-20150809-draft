# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal/gal-1.99.8.ebuild,v 1.3 2003/09/06 23:52:56 msterret Exp $

IUSE="doc"

inherit gnome2 gnome.org libtool

S="${WORKDIR}/${P}"
DESCRIPTION="The Gnome Application Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="x86 ~ppc ~sparc hppa"

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

MAKEOPTS="-j1"
USE_DESTDIR="1"
ELTCONF="--reverse-deps"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix
	# remove gtkdoc-fixxref
	cd ${S}; patch -p1 < ${FILESDIR}/gal-1.99.3-docfix.patch
}
