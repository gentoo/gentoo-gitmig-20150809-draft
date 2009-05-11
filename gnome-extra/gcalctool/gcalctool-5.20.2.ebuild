# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gcalctool/gcalctool-5.20.2.ebuild,v 1.9 2009/05/11 22:04:39 eva Exp $

inherit gnome2 eutils

DESCRIPTION="A calculator application for GNOME"
HOMEPAGE="http://calctool.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm sh"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.11.6
	>=dev-libs/glib-2
	>=dev-libs/atk-1.5
	>=gnome-base/gconf-2
	!<gnome-extra/gnome-utils-2.3"
DEPEND="${RDEPEND}
	sys-devel/gettext
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog* MAINTAINERS NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --enable-gnome"
}

src_unpack() {
	gnome2_src_unpack

	echo "gcalctool/ce_parser.tab.c" >> po/POTFILES.in
	echo "gcalctool/lr_parser.tab.c" >> po/POTFILES.in
}
