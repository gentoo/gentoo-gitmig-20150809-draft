# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-keyring-manager/gnome-keyring-manager-2.14.0.ebuild,v 1.10 2006/10/20 23:54:37 agriffis Exp $

inherit gnome2

DESCRIPTION="A keyring management program for the GNOME Desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="static"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/gnome-keyring-0.3.2
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.8
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable static) --disable-scrollkeeper"
}
