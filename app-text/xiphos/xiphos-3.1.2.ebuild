# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xiphos/xiphos-3.1.2.ebuild,v 1.3 2011/03/21 21:46:36 nirbheek Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="GTK+ based Bible study software, formerly gnomesword"
HOMEPAGE="http://xiphos.org/"
SRC_URI="mirror://sourceforge/gnomesword/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="xulrunner"

RDEPEND="dev-libs/glib:2
	>=x11-libs/gtk+-2.14:2
	dev-libs/libxml2:2
	>=gnome-base/libglade-2:2.0
	>=gnome-extra/gtkhtml-3.23:3.14
	>=app-text/sword-1.6
	dev-libs/dbus-glib
	gnome-extra/libgsf
	xulrunner? ( >=net-libs/xulrunner-1.9.1.3:1.9 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	app-text/rarian
	>=app-text/gnome-doc-utils-0.3.2"

pkg_setup() {
	G2CONF="--docdir=/usr/share/doc/${PF}
		--disable-dependency-tracking"

	if ! use xulrunner; then
		G2CONF="${G2CONF} --without-gecko"
	fi
}

src_install() {
	gnome2_src_install
	prepalldocs
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog "Xiphos requires modules to be of any use. You may install the"
	elog "sword modules packages in app-dicts/, or download modules"
	elog "individually from the sword website: http://crosswire.org/sword/"
}
