# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/spawn-fcgi/spawn-fcgi-1.2.0.ebuild,v 1.1 2004/11/02 20:09:47 stuart Exp $

inherit eutils

URI_ROOT="http://jan.kneschke.de/projects/lighttpd/download/"
DESCRIPTION="fast-cgi server for php and lighttpd"
HOMEPAGE="http://jan.kneschke.de/projects/lighttpd/"
SRC_URI="$URI_ROOT/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/libc
		>=dev-libs/libpcre-3.1
		>=sys-devel/libtool-1.4
		>=sys-libs/zlib-1.1"
RDEPEND=">=sys-libs/zlib-1.1
		 >=dev-php/php-cgi-4.3.0"
S=${WORKDIR}/${P}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	insinto /etc/conf.d
	newins ${FILESDIR}/${PN}-1.1.0.conf ${PN}.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}-1.1.0.initd ${PN}
	dodoc README doc/handbook.txt
}
