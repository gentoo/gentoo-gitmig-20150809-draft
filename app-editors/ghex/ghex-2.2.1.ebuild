# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-2.2.1.ebuild,v 1.9 2006/09/19 02:48:08 dang Exp $

inherit gnome2

DESCRIPTION="Gnome Hexadecimal editor"
HOMEPAGE="http://pluton.ijs.si/~jaka/gnome.html"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=gnome-base/gail-0.17
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprintui-2.2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"
