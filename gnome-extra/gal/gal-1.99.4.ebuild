# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal/gal-1.99.4.ebuild,v 1.1 2003/05/07 11:12:33 liquidx Exp $

IUSE="doc"

inherit gnome2 gnome.org libtool

S="${WORKDIR}/${P}"
DESCRIPTION="The Gnome Application Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/libgnomeprint-2.2.0
	>=gnome-base/libgnomeprintui-2.2.1
    >=gnome-base/libglade-2.0
    >=gnome-base/libgnomeui-2.0
    >=gnome-base/libgnomecanvas-2.0
    >=dev-libs/libxml2-2.0"
    
DEPEND="sys-devel/gettext
        doc? ( dev-util/gtk-doc )
        ${RDEPEND}"

MAKEOPTS="-j1"
USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix
	
	# patch sgml
	epatch ${FILESDIR}/${P}-sgml-fix2.patch
	epatch ${FILESDIR}/${P}-sgml-fix3.patch
	
	# remove gtkdoc-fixxref
	cd ${S}; patch -p1 < ${FILESDIR}/gal-1.99.3-docfix.patch
}	     
