# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgnomedb/libgnomedb-1.0.3.ebuild,v 1.8 2004/10/23 13:20:11 liquidx Exp $

inherit gnome2 eutils

DESCRIPTION="Library for writing gnome database programs"
HOMEPAGE="http://www.gnome-db.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha ~ia64"
IUSE="doc"

RDEPEND=">=gnome-extra/libgda-1.0.0
	>=x11-libs/gtk+-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/gconf-2"
# gtksourceview is maintained now, and configure checks it's presence
DEPEND=">=dev-util/pkgconfig-0.8
	>=dev-util/intltool-0.22
	>=sys-devel/gettext-0.11
	>=app-text/scrollkeeper-0.3.11
	doc? ( dev-util/gtk-doc )
	${RDEPEND}"

src_unpack() {
	unpack ${A}

	# needed for intltool-0.30
	cd ${S}; intltoolize --force || die
	# needed for inttool 0.31.3, alternative to running aclocal which
	# requires cvs files not in release tarball.
	sed -e 's/@INTLTOOL_ICONV@/iconv/' -i intltool-merge.in

	gnome2_omf_fix ${S}/doc/Makefile.in

	# Avoid documentation problems. See bug #46275.
	epatch ${FILESDIR}/${P}-gtkdoc_fix.patch
	# Fix GCC 3.4 compilation. See bug #49236.
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_install() {
	gnome2_src_install

	# minor cosmetic fix to capplet icon
	capplet_link=${D}/usr/share/control-center-2.0/capplets/database-properties.desktop
	if [ -f "${capplet_link}" ]; then
		mv ${capplet_link} ${capplet_link}.orig && \
		sed 's,Icon=gnome-db.png,Icon=libgnomedb/gnome-db.png,' ${capplet_link}.orig > ${capplet_link}
		rm ${capplet_link}.orig
	fi
}
