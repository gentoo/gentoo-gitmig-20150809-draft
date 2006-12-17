# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nemiver/nemiver-0.2.0.ebuild,v 1.1 2006/12/17 21:26:23 remi Exp $

inherit gnome2

DESCRIPTION="A gtkmm front end to the GNU Debugger (gdb)"
HOMEPAGE="http://home.gna.org/nemiver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
	>=dev-cpp/libglademm-2.6.0
	>=dev-cpp/libgtksourceviewmm-0.2.0
	>=gnome-base/libgtop-2.14.0
	>=x11-libs/vte-0.12.0
	>=gnome-base/gconf-2.14.0
	>=gnome-base/gnome-vfs-2.14.0
	>=dev-db/sqlite-3.0
	sys-devel/gdb
	dev-libs/boost
	"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README TODO"

G2CONF="${G2CONF} --enable-symbolsvisibilitycontrol=no"

gnome2_src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-0.2.0-breakpoints-fix.diff

	# Prevent scrollkeeper access violations
	gnome2_omf_fix
}


