# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/lighttpd/lighttpd-1.3.5.ebuild,v 1.3 2005/01/07 07:55:05 swegener Exp $

inherit eutils confutils

DESCRIPTION="lightweight high-performance web server"
HOMEPAGE="http://jan.kneschke.de/projects/lighttpd/"
SRC_URI="http://jan.kneschke.de/projects/lighttpd/download/${P}.tar.gz"
LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="mysql ssl php modchat modcache modlocalizer xattr ldap"
RDEPEND="virtual/libc
		>=dev-libs/libpcre-3.1
		>=sys-libs/zlib-1.1
		>=dev-libs/localizer-0.3.3
		mysql? ( >=dev-db/mysql-4.0.0 )
		ssl? ( >=dev-libs/openssl-0.9.7 )
		php? (
			>=dev-php/php-cgi-4.3.0
			net-www/spawn-fcgi
		)"

LIGHTTPD_DIR="/var/www/localhost/htdocs/"
LOG_DIR="/var/log/lighttpd/"

pkg_setup() {
	enewuser lighttpd -1 /bin/false "${LIGHTTPD_DIR}" nofiles
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
	local my_conf="--libdir=/usr/$(get_libdir)/${PN}"

	#                       extension		USE flag		shared?
	# -----------------------------------------------------------------
	enable_extension_enable mod-chat 		modchat			0
	enable_extension_enable mod-cache		modcache		0
	enable_extension_enable mod-localizer		modlocalizer		0
	enable_extension_enable attr			xattr			0
	enable_extension_enable ldap			ldap			0
	enable_extension_enable openssl			ssl			0
	enable_extension_enable mysql			mysql			0
	# -----------------------------------------------------------------
	#                       extension		USE flag		shared?

	econf ${my_conf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	insinto /etc
	doins doc/lighttpd.conf || die "doins failed"

	newinitd ${FILESDIR}/${PN}-1.2.2.initd ${PN} || die "newinitd failed"

	keepdir ${LIGHTTPD_DIR} ${LOG_DIR} || die "keepdir failed"
	fowners lighttpd:root ${LOG_DIR} || die "fowners failed"

	dodoc README COPYING doc/fastcgi.txt doc/authentification.txt || die "dodoc failed"
	newdoc doc/lighttpd.conf lighttpd.conf.example || die "newdoc failed"
}

pkg_postinst () {
	einfo "lighttpd.conf has moved from /etc/conf.d to /etc"
}
