# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.9.0.ebuild,v 1.5 2004/07/30 20:32:32 tgall Exp $

inherit eutils gnome2

DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="http://www.gnome.org/"

IUSE="gnome doc"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~sparc ~ppc ~hppa ~amd64 ~alpha ~ia64 ~mips ppc64"

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
	cd ${S}

	# Fix doc building and destination folder
	epatch ${FILESDIR}/${P}-gtkdoc_fixes.patch
}

G2CONF="${G2CONF} $(use_with gnome)"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
