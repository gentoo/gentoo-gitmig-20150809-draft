# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mergeant/mergeant-0.11.0.ebuild,v 1.4 2003/09/11 01:06:22 msterret Exp $

IUSE=""

inherit gnome2 gnome.org

S=${WORKDIR}/${P}
DESCRIPTION="Database admin tool using libgnomedb and libgda"
HOMEPAGE="http://www.gnome-db.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86"

RDEPEND=">=gnome-extra/libgnomedb-0.11.0
	>=gnome-extra/libgda-0.11.0
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
	${RDEPEND}"

src_install() {
	# redefined libdir so plugins don't get installed in /usr/lib
	gnome2_src_install "libdir=${D}/usr/share/mergeant/plugins" "dtddir=${D}/usr/share/mergeant/dtd/" "Mergeant_Lang_helpdir=${D}/usr/share/doc/mergeant/C" "scrollkeeper_localstate_dir=${D}/var/lib/scrollkeeper/" "Pixmapdir=${D}/usr/share/pixmaps/mergeant"
}
