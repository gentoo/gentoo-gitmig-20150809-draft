# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/lighttpd/lighttpd-1.3.10.ebuild,v 1.1 2005/02/14 11:39:01 ka0ttic Exp $

inherit eutils confutils

DESCRIPTION="lightweight high-performance web server"
HOMEPAGE="http://www.lighttpd.net/"
SRC_URI="http://www.lighttpd.net/download/${P}.tar.gz"
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
			!net-www/spawn-fcgi
		)"

LIGHTTPD_DIR="/var/www/localhost/htdocs/"
LOG_DIR="/var/log/lighttpd/"

pkg_setup() {
	enewgroup lighttpd
	enewuser lighttpd -1 /bin/false "${LIGHTTPD_DIR}" lighttpd
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.1.8-gentoo.diff
	use php && epatch ${FILESDIR}/${P}-php.diff
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
	make DESTDIR="${D}" install || die "make install failed"

	insinto /etc
	doins doc/lighttpd.conf || die "doins failed"

	newinitd ${FILESDIR}/${P}.initd ${PN}

	if use php ; then
		newinitd ${FILESDIR}/spawn-fcgi.initd spawn-fcgi
		newconfd ${FILESDIR}/spawn-fcgi.confd spawn-fcgi
	fi

	keepdir ${LIGHTTPD_DIR} ${LOG_DIR} || die "keepdir failed"
	fowners lighttpd:lighttpd ${LOG_DIR} || die "fowners failed"

	dodoc README COPYING
	cd doc
	dodoc *.txt *.sh *.ps.gz
	newdoc lighttpd.conf lighttpd.conf.example || die "newdoc failed"
}

pkg_postinst () {
	echo
	einfo "lighttpd.conf has moved from /etc/conf.d to /etc"
	if [[ -f ${ROOT}/etc/conf.d/spawn-fcgi.conf ]] ; then
		einfo
		einfo "spawn-fcgi is now included with lighttpd"
		einfo "spawn-fcgi's init script configuration is now located"
		einfo "at /etc/conf.d/spawn-fcgi."
	fi
	echo
}
