# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-query-browser/mysql-query-browser-1.1.2.ebuild,v 1.1 2004/12/01 20:04:57 swegener Exp $

inherit gnome2

DESCRIPTION="MySQL Query Browser"
HOMEPAGE="http://www.mysql.com/"
SRC_URI="mirror://mysql/Downloads/MySQLAdministrationSuite/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-db/mysql-4.1
	>=dev-libs/libpcre-4.4
	>=dev-libs/libxml2-2.6.2
	>=gnome-base/libglade-2
	=gnome-extra/libgtkhtml-3.0*
	>=dev-libs/glib-2
	=dev-cpp/gtkmm-2.2*"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11"

src_compile() {
	cd ${S}/mysql-gui-common
	econf --with-commondirname=common-query-browser || die "econf failed"
	emake -j1 || die "emake failed"

	cd ${S}/mysql-query-browser
	econf --with-commondirname=common-query-browser || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	USE_DESTDIR=1

	cd ${S}/mysql-gui-common
	gnome2_src_install || die "gnome2_src_install failed"

	cd ${S}/mysql-query-browser
	gnome2_src_install || die "gnome2_src_install failed"

	dohtml -r ${S}/mysql-query-browser/doc/ || die "dohtml failed"
}
