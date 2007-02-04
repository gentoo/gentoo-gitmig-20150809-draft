# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/glabels/glabels-2.0.4.ebuild,v 1.5 2007/02/04 19:07:12 beandog Exp $

inherit eutils gnome2

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://glabels.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.3.2
	>=gnome-base/libgnome-2.0.1
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libbonobo-2
	>=gnome-base/libbonoboui-2
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libglade-2.0.1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="--disable-update-mimedb --disable-update-desktopdb"
}

src_unpack() {
	unpack "${A}"

	gnome2_omf_fix "${S}"/help/C/Makefile.in
}
