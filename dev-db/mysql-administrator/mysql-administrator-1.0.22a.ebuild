# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-administrator/mysql-administrator-1.0.22a.ebuild,v 1.3 2005/06/25 12:02:48 swegener Exp $

inherit gnome2 eutils

DESCRIPTION="MySQL Administrator"
HOMEPAGE="http://www.mysql.com/products/administrator/"
SRC_URI="mirror://mysql/Downloads/MySQLAdministrationSuite/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
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

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-optional-4.1-support.patch
}

src_compile() {
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

	dohtml -r "${S}"/mysql-administrator/doc/ || die "dohtml failed"
}
