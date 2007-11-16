# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/nemiver/nemiver-0.4.0-r1.ebuild,v 1.1 2007/11/16 09:20:52 eva Exp $

inherit gnome2 eutils

DESCRIPTION="A gtkmm front end to the GNU Debugger (gdb)"
HOMEPAGE="http://home.gna.org/nemiver/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	>=dev-cpp/gtkmm-2.10.0
	>=dev-cpp/libglademm-2.6.0
	>=dev-cpp/libgtksourceviewmm-0.3.0
	>=gnome-base/libgtop-2.19.0
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

src_unpack() {
	gnome2_src_unpack

	# patch for libgtop >= 2.19, already in nemiver svn
	epatch "${FILESDIR}/${PN}-0.4.0-libgtop.patch"
}
