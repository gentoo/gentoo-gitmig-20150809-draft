# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-administrator/mysql-administrator-1.1.10.ebuild,v 1.5 2007/01/31 13:47:33 genone Exp $

inherit gnome2 eutils flag-o-matic

DESCRIPTION="MySQL Administrator"
HOMEPAGE="http://www.mysql.com/products/tools/administrator/"
SRC_URI="mirror://mysql/Downloads/MySQLAdministrationSuite/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND="virtual/mysql
	>=dev-libs/libpcre-4.4
	>=dev-libs/libxml2-2.6.2
	>=gnome-base/libglade-2
	>=dev-libs/glib-2
	=dev-cpp/gtkmm-2.8*"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11"
RDEPEND="${RDEPEND}
	!dev-db/mysql-gui-tools"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/1.1.10-i18n-fix.patch

	echo "Categories=Application;Development;" >>"${S}"/mysql-administrator/MySQLAdministrator.desktop.in
}

src_compile() {
	# mysql has -fno-exceptions, but we need exceptions
	append-flags -fexceptions

	cd "${S}"/mysql-gui-common
	econf --with-commondirname=common/administrator || die "econf failed"
	emake -j1 || die "emake failed"

	cd "${S}"/mysql-administrator
	econf --with-commondirname=common/administrator || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	USE_DESTDIR=1

	cd "${S}"/mysql-gui-common
	gnome2_src_install || die "gnome2_src_install failed"

	cd "${S}"/mysql-administrator
	gnome2_src_install || die "gnome2_src_install failed"
}

pkg_postinst() {
	elog "To use the 'Edit Table Data' feature,"
	elog "you need to emerge dev-db/mysql-query-browser!"
}
