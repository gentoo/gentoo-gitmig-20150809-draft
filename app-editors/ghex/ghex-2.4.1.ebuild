# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-2.4.1.ebuild,v 1.1 2004/02/14 12:56:07 liquidx Exp $

inherit gnome2

DESCRIPTION="Gnome hexadecimal editor"
HOMEPAGE="http://www.gnome.org/softwaremap/projects/ghex/"

IUSE=""
SLOT="2"
LICENSE="GPL-2 FDL-1.1"
KEYWORDS="~x86 ~sparc"

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

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"

MAKEOPTS="-j1"

src_unpack() {
	unpack ${A}
	cd ${S}; gnome2_omf_fix
}
