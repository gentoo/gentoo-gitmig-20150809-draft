# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmymoney2/kmymoney2-0.9.3.ebuild,v 1.1 2009/05/28 23:55:02 tgurr Exp $

EAPI="2"
inherit kde

DESCRIPTION="Personal Finances Manager for KDE."
HOMEPAGE="http://kmymoney2.sourceforge.net"
SRC_URI="mirror://sourceforge/kmymoney2/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt ofx qtdesigner sqlite3 test"

COMMON_DEPEND="dev-libs/libxml2
	ofx? ( >=dev-libs/libofx-0.8.2
	|| ( dev-cpp/libxmlpp:2.6 >=dev-cpp/libxmlpp-1.0.1:0 )
	>=net-misc/curl-7.9.7
	app-text/opensp )
	sqlite3? ( =dev-db/sqlite-3* )"

DEPEND="${COMMON_DEPEND}
	>=dev-util/pkgconfig-0.9.0
	test? ( >=dev-util/cppunit-1.8.0 )"

RDEPEND="${COMMON_DEPEND}
	crypt? ( app-crypt/gnupg )"

need-kde 3.5

src_configure() {
	local myconf
	myconf="${myconf} \
		$(use_enable ofx ofxplugin)
		$(use_enable ofx ofxbanking)
		$(use_enable qtdesigner)
		$(use_enable sqlite3)
		$(use_enable test cppunit)"

	kde_src_configure
}

src_test() {
	# Parallel make check is broken
	make -j1 check || die "Make check failed!"
}

pkg_postinst() {
	echo
	elog "If you want HBCI support in ${P}, please install app-office/kmm_kbanking separately."
	echo
}
