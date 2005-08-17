# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/lighttpd/lighttpd-1.4.0.20050817.1210.ebuild,v 1.1 2005/08/17 15:45:28 ka0ttic Exp $

inherit eutils versionator

RESTRICT="test"

MY_PV="$(get_version_component_range 1-2).$(replace_all_version_separators '-' "$(get_version_component_range '3-5')")"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${PN}-${MY_PV%%-*}"
DESCRIPTION="lightweight high-performance web server"
HOMEPAGE="http://www.lighttpd.net/"
SRC_URI="http://www.lighttpd.net/download/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
IUSE="mysql ssl php xattr ldap ipv6"

RDEPEND="virtual/libc
		app-arch/bzip2
		>=dev-libs/libpcre-3.1
		>=sys-libs/zlib-1.1
		ldap? ( >=net-nds/openldap-2.1.26 )
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
	enewuser lighttpd -1 -1 "${LIGHTTPD_DIR}" lighttpd
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.3.11-gentoo.diff
#    epatch ${FILESDIR}/${PN}-1.3.13-no-mysql-means-no-mysql.diff
	use php && epatch ${FILESDIR}/${PN}-1.3.13-php.diff

	epatch ${FILESDIR}/${P}-fix-config-segv.diff
}

src_compile() {
#    einfo "Regenerating automake/autoconf files"
#    autoreconf -f -i || die "autoreconf failed"

	econf \
		--libdir=/usr/$(get_libdir)/${PN} \
		--enable-lfs \
		$(use_enable ipv6) \
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
	dodoc *.txt *.sh
	newdoc lighttpd.conf lighttpd.conf.example || die "newdoc failed"
}

pkg_postinst () {
	if [[ -f ${ROOT}/etc/conf.d/spawn-fcgi.conf ]] ; then
		einfo
		einfo "spawn-fcgi is now included with lighttpd"
		einfo "spawn-fcgi's init script configuration is now located"
		einfo "at /etc/conf.d/spawn-fcgi."
		einfo
	fi
}
