# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-query-browser/mysql-query-browser-1.1.18.ebuild,v 1.7 2006/10/22 17:09:46 swegener Exp $

inherit gnome2 eutils

DESCRIPTION="MySQL Query Browser"
HOMEPAGE="http://www.mysql.com/products/tools/query-browser/"
SRC_URI="mirror://mysql/Downloads/MySQLAdministrationSuite/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-db/mysql-4.0
	>=dev-libs/libpcre-4.4
	>=dev-libs/libxml2-2.6.2
	>=gnome-base/libglade-2
	=gnome-extra/gtkhtml-3.0*
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

	epatch "${FILESDIR}"/1.1.18-gtk-fix.patch
	epatch "${FILESDIR}"/1.1.18-gcc41-fix.patch

	echo "Categories=Application;Development;" >>"${S}"/mysql-query-browser/MySQLQueryBrowser.desktop.in
}

src_compile() {
	cd "${S}"/mysql-gui-common
	econf --with-commondirname=common/query-browser || die "econf failed"
	emake || die "emake failed"

	cd "${S}"/mysql-query-browser
	econf --with-commondirname=common/query-browser || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	USE_DESTDIR=1

	cd "${S}"/mysql-gui-common
	gnome2_src_install || die "gnome2_src_install failed"

	cd "${S}"/mysql-query-browser
	gnome2_src_install || die "gnome2_src_install failed"
}
