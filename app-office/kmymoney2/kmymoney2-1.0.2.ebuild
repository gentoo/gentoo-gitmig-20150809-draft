# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney2/kmymoney2-1.0.2.ebuild,v 1.2 2009/11/09 21:15:31 ssuominen Exp $

EAPI=2
ARTS_REQUIRED=never
inherit kde

DESCRIPTION="Personal Finances Manager for KDE."
HOMEPAGE="http://kmymoney2.sourceforge.net"
SRC_URI="mirror://sourceforge/kmymoney2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt ofx qtdesigner sqlite test"

COMMON_DEPEND="dev-libs/libxml2
	ofx? ( >=dev-libs/libofx-0.8.2
	|| ( dev-cpp/libxmlpp:2.6 >=dev-cpp/libxmlpp-1.0.1:0 )
	>=net-misc/curl-7.9.7
	app-text/opensp )
	sqlite? ( =dev-db/sqlite-3* )"

DEPEND="${COMMON_DEPEND}
	>=dev-util/pkgconfig-0.9.0
	test? ( >=dev-util/cppunit-1.8.0 )"

RDEPEND="${COMMON_DEPEND}
	crypt? (
		app-crypt/gnupg
		app-crypt/pinentry
	)"

need-kde 3.5

src_configure() {
	local myconf="$(use_enable ofx ofxplugin)
		$(use_enable ofx ofxbanking)
		$(use_enable qtdesigner)
		$(use_enable sqlite sqlite3)
		$(use_enable test cppunit)"

	kde_src_configure
}

src_test() {
	emake -j1 check || die
}

pkg_postinst() {
	echo
	elog "If you want HBCI support in ${P}, please install app-office/kmm_kbanking separately."
	echo
}
