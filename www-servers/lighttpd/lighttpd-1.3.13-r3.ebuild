# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/lighttpd/lighttpd-1.3.13-r3.ebuild,v 1.11 2006/04/27 18:35:39 chtekk Exp $

inherit eutils depend.php

RESTRICT="test"

DESCRIPTION="lightweight high-performance web server"
HOMEPAGE="http://www.lighttpd.net/"
SRC_URI="http://www.lighttpd.net/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="mysql ssl php xattr ldap"

RDEPEND="app-arch/bzip2
		>=dev-libs/libpcre-3.1
		>=sys-libs/zlib-1.1
		xattr? ( sys-apps/attr )
		ldap? ( >=net-nds/openldap-2.1.26 )
		mysql? ( >=dev-db/mysql-4.0.0 )
		ssl? ( >=dev-libs/openssl-0.9.7 )
		php? (
			virtual/httpd-php
			!net-www/spawn-fcgi
		)"

LIGHTTPD_DIR="/var/www/localhost/htdocs/"
LOG_DIR="/var/log/lighttpd/"

pkg_setup() {
	enewgroup lighttpd
	enewuser lighttpd -1 -1 "${LIGHTTPD_DIR}" lighttpd

	use php && require_php_with_use cgi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.3.11-gentoo.diff
	epatch ${FILESDIR}/${P}-no-mysql-means-no-mysql.diff
	epatch ${FILESDIR}/${P}-zope-deserves-lovins-too.diff
	epatch ${FILESDIR}/${P}-pam-name.diff
	epatch ${FILESDIR}/${P}-valid-user.diff
	epatch ${FILESDIR}/${P}-ldap-binddn.diff
	use php && epatch ${FILESDIR}/${P}-php.diff
}

src_compile() {
	local my_conf="--libdir=/usr/$(get_libdir)/${PN}"

	# somehow during the process the BSD COPYING gets
	# overwritten with a GPL one
	mv COPYING{,.orig}
	einfo "Regenerating automake/autoconf files"
	autoreconf -f -i || die "autoreconf failed"
	mv COPYING{.orig,}

	econf ${my_conf} \
		$(use_with mysql) \
		$(use_with ldap) \
		$(use_with xattr attr) \
		$(use_with ssl openssl) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	insinto /etc
	doins doc/lighttpd.conf || die "doins failed"

	newinitd ${FILESDIR}/${PN}-1.3.10.initd ${PN}

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
