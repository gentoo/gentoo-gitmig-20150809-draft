# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-2.8.1.ebuild,v 1.1 2004/12/01 19:44:44 joem Exp $

inherit gnome2

DESCRIPTION="Gnome hexadecimal editor"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

RDEPEND=">=gnome-base/gail-0.17
	>=x11-libs/gtk+-2.4
	>=dev-libs/atk-1
	>=gnome-base/gconf-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libbonoboui-2
	>=gnome-base/libgnomeprintui-2.2"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.30
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}; gnome2_omf_fix
}
