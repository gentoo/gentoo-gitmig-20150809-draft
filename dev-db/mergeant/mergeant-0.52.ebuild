# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mergeant/mergeant-0.52.ebuild,v 1.1 2005/05/12 18:36:21 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="Front-end for database administrators and developers"
HOMEPAGE="http://www.gnome-db.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE="debug doc static"

RDEPEND=">=gnome-extra/libgnomedb-1.1.3
	>=gnome-extra/libgda-1.1.3
	>=gnome-base/libbonoboui-2
	>=gnome-base/gconf-2
	>=x11-libs/gtk+-2.4
	dev-libs/libxml2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.11
	app-text/scrollkeeper
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} $(use_enable debug debug-signal) $(use_enable static)"
USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	gnome2_omf_fix ${S}/doc/Makefile.in

	cd ${S}
	# Fix location of a header file
	epatch ${FILESDIR}/${P}-include_fix.patch
}
