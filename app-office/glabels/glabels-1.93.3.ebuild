# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/glabels/glabels-1.93.3.ebuild,v 1.5 2004/11/25 16:13:19 obz Exp $

inherit gnome2

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://glabels.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.0.5
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/libbonobo-2
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libglade-2.0.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.21
	app-text/scrollkeeper"

DOCS="AUTHORS ChangeLog README TODO"

src_unpack() {
	unpack ${A}
	# Small syntax correction.
	sed -i -e 's:;Office:;Office;:' ${S}/data/glabels.desktop.in
}
