# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-keyring-manager/gnome-keyring-manager-2.11.1.ebuild,v 1.3 2005/08/18 11:42:14 seemant Exp $

inherit gnome2

DESCRIPTION="A keyring management program for the GNOME Desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="static"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/gnome-keyring-0.3.2
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.8
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_enable static)"
}

src_unpack() {
	unpack ${A}

	gnome2_omf_fix ${S}/docs/Makefile.in
}
