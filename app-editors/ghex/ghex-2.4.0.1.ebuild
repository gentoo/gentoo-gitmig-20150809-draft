# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-2.4.0.1.ebuild,v 1.7 2004/10/05 12:19:43 pvdabeel Exp $

inherit gnome2

DESCRIPTION="Gnome hexadecimal editor"
HOMEPAGE="http://pluton.ijs.si/~jaka/gnome.html"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="x86 sparc ppc"
IUSE=""

RDEPEND=">=gnome-base/gail-0.17
	>=x11-libs/gtk+-2
	>=dev-libs/atk-1
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprintui-2.2"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/intltool
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnome2_omf_fix
}
