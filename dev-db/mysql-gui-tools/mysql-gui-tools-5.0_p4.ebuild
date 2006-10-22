# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-gui-tools/mysql-gui-tools-5.0_p4.ebuild,v 1.1 2006/10/22 17:18:27 swegener Exp $

GCONF_DEBUG="no"

inherit gnome2 eutils flag-o-matic

MY_P="${P/_p/r}"

DESCRIPTION="MySQL GUI Tools"
HOMEPAGE="http://www.mysql.com/products/tools/"
SRC_URI="mirror://mysql/Downloads/MySQLGUITools/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6
	>=gnome-base/libglade-2.5
	>=dev-libs/libsigc++-2.0
	>=dev-libs/libpcre-4.4
	>=dev-libs/libxml2-2.6.2
	=dev-cpp/glibmm-2.12*
	=dev-cpp/gtkmm-2.10*
	=gnome-extra/gtkhtml-3.12*
	>=dev-db/mysql-5	"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15
	>=app-text/scrollkeeper-0.3.11"
RDEPEND="${RDEPEND}
	!dev-db/mysql-administrator
	!dev-db/mysql-query-browser"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	gnome2_src_unpack
	cd "${S}"

	epatch "${FILESDIR}"/${P}-lua-modules.patch
}

src_compile() {
	# mysql has -fno-exceptions, but we need exceptions
	append-flags -fexceptions

	cd "${S}"/mysql-gui-common
	gnome2_src_compile $(use_enable nls i18n)

	cd "${S}"/mysql-administrator
	gnome2_src_compile $(use_enable nls i18n)

	cd "${S}"/mysql-query-browser
	gnome2_src_compile --with-gtkhtml=libgtkhtml-3.8

#	cd "${S}"/mysql-workbench
#	gnome2_src_compile
}

src_install() {
	cd "${S}"/mysql-gui-common
	gnome2_src_install

	cd "${S}"/mysql-administrator
	gnome2_src_install

	cd "${S}"/mysql-query-browser
	gnome2_src_install

#	cd "${S}"/mysql-workbench
#	gnome2_src_install
}
