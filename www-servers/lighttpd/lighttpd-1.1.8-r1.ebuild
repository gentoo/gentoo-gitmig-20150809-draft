# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/lighttpd/lighttpd-1.1.8-r1.ebuild,v 1.2 2005/01/04 13:34:15 swegener Exp $

inherit eutils

DESCRIPTION="lighttpd is intended to be a frontend for ad-servers which have to deliver small files concurrently to many connections."
HOMEPAGE="http://jan.kneschke.de/projects/lighttpd"
SRC_URI="http://jan.kneschke.de/projects/lighttpd/download/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="mysql ssl"
DEPEND="virtual/libc
		>=dev-libs/libpcre-3.1
		>=sys-libs/zlib-1.1
		>=sys-devel/libtool-1.4
		mysql? ( >=dev-db/mysql-4.0.0 )
		ssl?   ( >=dev-libs/openssl-0.9.7 )"
RDEPEND=">=sys-libs/zlib-1.1
		 >=sys-devel/libtool-1.4
		 mysql? ( >=dev-db/mysql-4.0.0 )
		 ssl?   ( >=dev-libs/openssl-0.9.7 )"
S=${WORKDIR}/${P}
LIGHTTPD_DIR="/var/www/localhost/htdocs/"
LOG_DIR="/var/log/lighttpd/"

pkg_setup() {
	if ! grep -q ^lighttpd: /etc/passwd ; then
		useradd  -g nofiles -s /bin/false -d ${LIGHTTPD_DIR} \
			-c "lighttpd" lighttpd || die "problem adding user lighttpd"
	fi
}

src_compile() {
	epatch ${FILESDIR}/lighttpd-1.1.8-gentoo.diff
	if use ssl; then
		USE_SSL="--with-openssl"
	fi
	econf --libdir=/usr/lib/${PN} \
		`use_with mysql` \
		${USE_SSL} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README COPYING
	newdoc doc/lighttpd.conf lighttpd.conf.example
	dodoc doc/fastcgi.txt doc/authentification.txt
	insinto /etc/conf.d/;  doins doc/lighttpd.conf
	exeinto /etc/init.d;   newexe ${FILESDIR}/lighttpd.initd lighttpd
	dodir ${LIGHTTPD_DIR} ${LOG_DIR}
	chown lighttpd:root ${D}/${LOG_DIR}
}

pkg_postinst() {
	einfo "In order to use fast-cgi for php you have to emerge dev-php/php-cgi and"
	einfo "please read /usr/share/doc/lighttpd-1.1.8/fastcgi.txt.gz for more information"
}
