# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/lighttpd/lighttpd-1.2.2.ebuild,v 1.2 2004/09/03 15:58:51 pvdabeel Exp $

inherit eutils

URI_ROOT="http://jan.kneschke.de/projects/lighttpd/download/"
DESCRIPTION="lightweight high-performance web server"
HOMEPAGE="http://jan.kneschke.de/projects/lighttpd/"
SRC_URI="$URI_ROOT/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="mysql ssl php"
DEPEND="virtual/libc
		>=dev-libs/libpcre-3.1
		>=sys-libs/zlib-1.1
		>=sys-devel/libtool-1.4
		>=dev-libs/localizer-0.3.3
		mysql? ( >=dev-db/mysql-4.0.0 )
		ssl?   ( >=dev-libs/openssl-0.9.7 )
		php?   ( >=dev-php/php-cgi-4.3.0 net-www/spawn-fcgi )"
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

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.1.8-gentoo.diff
	if useq php ; then
		epatch ${FILESDIR}/${PN}-1.2.2-php.diff
	fi
}

src_compile() {
	local my_conf

	my_conf="--libdir=/usr/lib/${PN}"
	my_conf="$my_conf `use_with ssl openssl`"
	my_conf="$my_conf `use_with ldap`"
	my_conf="$my_conf `use_with mysql`"
	my_conf="$my_conf --enable-mod-localizer"
	econf $my_conf || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README COPYING
	newdoc doc/lighttpd.conf lighttpd.conf.example
	dodoc doc/fastcgi.txt doc/authentification.txt
	insinto /etc;  doins doc/lighttpd.conf
	exeinto /etc/init.d;   newexe ${FILESDIR}/${PN}-${PV}.initd ${PN}
	dodir ${LIGHTTPD_DIR} ${LOG_DIR}
	chown lighttpd:root ${D}/${LOG_DIR}
}

pkg_postinst () {
	einfo "lighttpd.conf has moved from /etc/conf.d to /etc"
}
