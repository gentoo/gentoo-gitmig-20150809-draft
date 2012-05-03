# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-2.24.0.ebuild,v 1.13 2012/05/03 18:33:01 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Gnome hexadecimal editor"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="amd64 ppc x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.13:2
	dev-libs/popt
	>=dev-libs/atk-1
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libgnomeprintui-2.2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.3.2"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} --disable-static"
}
