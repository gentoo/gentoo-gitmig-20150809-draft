# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-administrator/mysql-administrator-1.0.13.ebuild,v 1.1 2004/10/21 23:39:26 swegener Exp $

inherit gnome2

DESCRIPTION="MySQL Administrator"
HOMEPAGE="http://www.mysql.com/products/administrator/"
SRC_URI="mirror://mysql/Downloads/MySQLAdministrationSuite/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="dev-db/mysql
	>=dev-libs/libpcre-4.4
	>=dev-libs/libxml2-2.6.2
	>=gnome-base/libglade-2
	>=dev-libs/glib-2
	=dev-cpp/gtkmm-2.2*"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11"

src_compile() {
	cd ${S}/mysql-gui-common
	econf --with-commondirname=common-administrator || die "econf failed"
	emake -j1 || die "emake failed"

	cd ${S}/mysql-administrator
	econf --with-commondirname=common-administrator || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	USE_DESTDIR=1

	cd ${S}/mysql-gui-common
	gnome2_src_install || die "gnome2_src_install failed"

	cd ${S}/mysql-administrator
	gnome2_src_install || die "gnome2_src_install failed"

	rm ${D}/usr/bin/mysql-administrator
	dobin ${FILESDIR}/mysql-administrator || die "dobin failed"

	dohtml -r ${S}/mysql-administrator/doc/{resources,mysqladministrator.html,html.css}
}
