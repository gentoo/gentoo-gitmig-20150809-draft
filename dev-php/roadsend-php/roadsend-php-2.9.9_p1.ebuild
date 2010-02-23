# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/roadsend-php/roadsend-php-2.9.9_p1.ebuild,v 1.1 2010/02/23 03:49:40 yngwin Exp $

EAPI=2
inherit eutils

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

DESCRIPTION="PHP compiler"
HOMEPAGE="http://code.roadsend.com/pcc"
SRC_URI="http://code.roadsend.com/snaps/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fastcgi mysql odbc pcre sqlite xml"

DEPEND="dev-scheme/bigloo
	net-misc/curl
	mysql? ( dev-db/mysql )
	sqlite? ( dev-db/sqlite:3 )
	pcre? ( dev-libs/libpcre )
	xml? ( dev-libs/libxml2 )
	odbc? ( dev-db/unixODBC )
	fastcgi? ( dev-libs/fcgi )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf $(use_with pcre) \
		$(use_with fastcgi fcgi) \
		$(use_with xml) \
		$(use_with mysql) \
		$(use_with sqlite sqlite3) \
		$(use_with odbc)
}

src_compile() {
	if use debug; then
		emake -j1 debug || die "make debug failed"
	else
		emake -j1 || die "make failed"
	fi
}

src_test() {
	LD_LIBRARY_PATH="${S}/libs/" emake -j1 test || die "standalone tests failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
}
