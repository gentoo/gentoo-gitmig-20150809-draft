# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-gui-tools/mysql-gui-tools-5.0_p11.ebuild,v 1.2 2007/04/03 21:31:17 swegener Exp $

GCONF_DEBUG="no"

inherit gnome2 eutils flag-o-matic

MY_P="${P/_p/r}"

DESCRIPTION="MySQL GUI Tools"
HOMEPAGE="http://www.mysql.com/products/tools/"
SRC_URI="mirror://mysql/Downloads/MySQLGUITools/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls administrator query-browser workbench"

RDEPEND=">=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6
	>=gnome-base/libglade-2.5
	>=dev-libs/libsigc++-2.0
	>=dev-libs/libpcre-4.4
	>=dev-libs/libxml2-2.6.2
	=dev-cpp/glibmm-2.12*
	=dev-cpp/gtkmm-2.10*
	=gnome-extra/gtkhtml-3.12*
	>=virtual/mysql-5.0
	workbench? (
		=dev-lang/lua-5.0*
		virtual/opengl
	)"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15
	>=app-text/scrollkeeper-0.3.11"
RDEPEND="${RDEPEND}
	!dev-db/mysql-administrator
	!dev-db/mysql-query-browser"

S="${WORKDIR}"/${MY_P}

pkg_setup() {
	if ! use administrator && ! use query-browser && ! use workbench
	then
		elog "Please activate at least one of the following USE flags:"
		elog "- administrator for MySQL Administrator"
		elog "- query-browser for MySQL Query Browser"
		elog "- workbench for MySQL Workbench"
		die "Please activate at least one of the following USE flags: administrator, query-browser, workbench"
	fi
}

src_unpack() {
	gnome2_src_unpack
	cd "${S}"

	epatch "${FILESDIR}"/mysql-gui-tools-5.0_p8-i18n-fix.patch
	epatch "${FILESDIR}"/mysql-gui-tools-5.0_p8-lua-modules.patch
}

src_compile() {
	# mysql has -fno-exceptions, but we need exceptions
	append-flags -fexceptions

	cd "${S}"/mysql-gui-common
	sed -i -e "s/\\b-ltermcap\\b//g" tools/{grtsh,grtsh3}/Makefile.{am,in}
	use nls || sed -i -e "/^SUBDIRS = / s/\\bpo\\b//" Makefile.{am,in}
	gnome2_src_compile \
		--disable-java-modules \
		$(use_enable workbench grt) \
		$(use_enable workbench canvas) \
		$(use_enable nls i18n)

	if use administrator
	then
		cd "${S}"/mysql-administrator
		use nls || sed -i -e "/^SUBDIRS = / s/\\bpo\\b//" Makefile.{am,in}
		gnome2_src_compile $(use_enable nls i18n)
	fi

	if use query-browser
	then
		cd "${S}"/mysql-query-browser
		use nls || sed -i -e "/^SUBDIRS=/ s/\\bpo\\b//" Makefile.{am,in}
		gnome2_src_compile --with-gtkhtml=libgtkhtml-3.8
	fi

	if use workbench
	then
		cd "${S}"/mysql-workbench
		use nls || sed -i -e "/^SUBDIRS=/ s/\\bpo\\b//" Makefile.{am,in}
		gnome2_src_compile
	fi
}

src_install() {
	cd "${S}"/mysql-gui-common
	gnome2_src_install

	if use administrator
	then
		cd "${S}"/mysql-administrator
		gnome2_src_install
	fi

	if use query-browser
	then
		cd "${S}"/mysql-query-browser
		gnome2_src_install
	fi

	if use workbench
	then
		cd "${S}"/mysql-workbench
		gnome2_src_install
	fi
}
