# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mergeant/mergeant-0.12.0.ebuild,v 1.1 2003/06/03 10:33:16 liquidx Exp $

IUSE=""

inherit gnome2 gnome.org

DESCRIPTION="Database admin tool using libgnomedb and libgda"
HOMEPAGE="http://www.gnome-db.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86"

RDEPEND=">=gnome-extra/libgnomedb-0.12.0
	>=gnome-extra/libgda-0.12.0
	>=gnome-base/libbonobo-2.0
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/gconf-2.0
	>=x11-libs/gtk+-2.0
	>=dev-libs/libxml2-2.5
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libglade-2.0"

DEPEND=">=dev-util/pkgconfig-0.8
	>=dev-util/intltool-0.22
	app-text/scrollkeeper
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix ${S}/doc/Makefile.in
}

src_install() {
    # redefined libdir so plugins don't get installed in /usr/lib
	gnome2_src_install "libdir=${D}/usr/share/mergeant/plugins" "dtddir=${D}/usr/share/mergeant/dtd/" "Mergeant_Lang_helpdir=${D}/usr/share/doc/mergeant/C" "scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/" "Pixmapdir=${D}/usr/share/pixmaps/mergeant"
}
