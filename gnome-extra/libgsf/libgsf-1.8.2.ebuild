# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.8.2.ebuild,v 1.9 2004/03/20 20:01:55 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="http://www.gnome.org/"

IUSE="gnome doc"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 sparc ppc hppa amd64 alpha ia64 ~mips"

# FIXME : should add optional bz2 support
RDEPEND=">=dev-libs/libxml2-2.4.16
	 >=dev-libs/glib-2
	 >=sys-libs/zlib-1.1.4
	 gnome? ( >=gnome-base/libbonobo-2
	  	>=gnome-base/gnome-vfs-2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=sys-apps/sed-4
	doc? ( >=dev-util/gtk-doc-0.9 )"

src_unpack() {
	unpack ${A}
	sed -e "s:doc\$(TARGET_DIR):\$(TARGET_DIR):" \
		-i ${S}/doc/Makefile.in
	cd ${S}
	epatch ${FILESDIR}/${P}-gtkdoc_fix.patch
}

G2CONF="${G2CONF} $(use_with gnome)"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
