# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glabels/glabels-1.93.2.ebuild,v 1.1 2004/02/14 13:00:56 liquidx Exp $

inherit gnome2

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://glabels.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~x86"
SLOT="0"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/libbonobo-2
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.8
	>=dev-util/intltool-0.30
	sys-devel/gettext"

DOCS="AUTHORS COPYING INSTALL README TODO"

src_unpack() {

	unpack ${A}
	# a slightly changed .desktop file, so we can actually have
	# a menu item <obz@gentoo.org>
	cp ${FILESDIR}/glabels-1.92.0.desktop ${S}/data/glabels.desktop

}

