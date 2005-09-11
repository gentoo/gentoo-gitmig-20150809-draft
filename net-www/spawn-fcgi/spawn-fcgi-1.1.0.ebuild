# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/spawn-fcgi/spawn-fcgi-1.1.0.ebuild,v 1.5 2005/09/11 13:41:03 rl03 Exp $

inherit eutils depend.php

URI_ROOT="http://jan.kneschke.de/projects/lighttpd/download/"
DESCRIPTION="fast-cgi server for php and lighttpd"
HOMEPAGE="http://jan.kneschke.de/projects/lighttpd/"
SRC_URI="$URI_ROOT/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/libc
		>=dev-libs/libpcre-3.1
		>=sys-libs/zlib-1.1"
RDEPEND=">=sys-libs/zlib-1.1
		 >=sys-devel/libtool-1.4
		 virtual/httpd-php"

pkg_setup() {
	require_php_with_use cgi
}

src_install() {
	make DESTDIR=${D} install || die
	insinto /etc/conf.d
	newins ${FILESDIR}/${P}.conf ${PN}.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/${P}.initd ${PN}
	dodoc README doc/handbook.txt
}
