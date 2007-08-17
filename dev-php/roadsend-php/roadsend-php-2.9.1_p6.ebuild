# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/roadsend-php/roadsend-php-2.9.1_p6.ebuild,v 1.2 2007/08/17 08:22:22 opfer Exp $

MY_PVL=${PV/_p/-r}
MY_PV=${PV%%_p[0-9]}
MY_PL=${PN}-${MY_PVL}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Roadsend PHP compiler"
HOMEPAGE="http://code.roadsend.com/pcc"
SRC_URI="http://code.roadsend.com/snaps/${MY_PL}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"

KEYWORDS="~amd64 ~x86"

DEPEND="dev-scheme/bigloo
		>=net-misc/curl-7.15.1-r1
		mysql? ( dev-db/mysql )
		sqlite3? ( >=dev-db/sqlite-3.3.12 )
		pcre? ( >=dev-libs/libpcre-6.6 )
		xml? ( dev-libs/libxml2 )
		odbc? ( dev-db/unixODBC )
		fastcgi? ( dev-libs/fcgi )"

RDEPEND="${DEPEND}"
SLOT="0"

#IUSE="debug fastcgi mysql odbc pcre sqlite3 xml"
IUSE="fastcgi mysql odbc pcre sqlite3 xml"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_with pcre) $(use_with fastcgi fcgi) $(use_with xml) $(use_with mysql) $(use_with sqlite3) $(use_with odbc)

#	if use debug; then
		emake -j1 || die "make debug failed"
#	else
#		emake -j1 unsafe || die "make failed"
#	fi
}

src_test() {
	LD_LIBRARY_PATH="${S}/libs/" emake -j1 test || die "standalone tests failed"
}

src_install() {
	emake -j1 DESTDIR=${D} install || die "make install failed"
}
