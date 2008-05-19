# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rsyslog/rsyslog-3.19.2.ebuild,v 1.1 2008/05/19 16:13:44 dev-zero Exp $

inherit autotools eutils versionator

DESCRIPTION="An enhanced multi-threaded syslogd with database support and more."
HOMEPAGE="http://www.rsyslog.com/"
SRC_URI="http://download.rsyslog.com/${PN}/${P}.tar.gz"
LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kerberos dbi gnutls mysql postgres relp snmp zlib"

DEPEND="kerberos? ( virtual/krb5 )
	dbi? ( dev-db/libdbi )
	gnutls? ( net-libs/gnutls )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-base )
	relp? ( >=dev-libs/librelp-0.1.1 )
	snmp? ( net-analyzer/net-snmp )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

BRANCH="3-devel"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-as_needed.patch"
	eautomake
}

src_compile() {
	# Maintainer notes:
	# * rsyslog-3 doesn't support single threading anymore
	# * rfc3195 needs a library
	# * OpenSSL detection is present in ./configure but nothing
	#   in the code actually needs it
	econf \
		--enable-largefile \
		--enable-regexp \
		$(use_enable zlib) \
		$(use_enable kerberos gssapi-krb5) \
		--enable-pthreads \
		--enable-klog \
		--enable-unix \
		--enable-inet \
		--enable-fsstnd \
		$(use_enable debug) \
		$(use_enable debug rtinst) \
		$(use_enable mysql) \
		$(use_enable postgres pgsql) \
		$(use_enable dbi libdbi) \
		$(use_enable snmp) \
		--enable-rsyslogd \
		--enable-mail \
		$(use_enable relp) \
		--disable-rfc3195 \
		--enable-imfile \
		--disable-imtemplate \
		$(use_enable gnutls)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /usr/share/doc/${PF}/scripts/mysql
	doins plugins/ommysql/{createDB.sql,contrib/delete_mysql}

	insinto /usr/share/doc/${PF}/scripts/pgsql
	doins plugins/ompgsql/createDB.sql

	elog "SQL scripts to create the tables for MySQL or PostgreSQL have been installed to:"
	elog "  /usr/share/doc/${PF}/scripts"

	dodoc AUTHORS ChangeLog doc/rsyslog-example.conf
	dohtml doc/*

	insinto /etc
	newins "${FILESDIR}/${BRANCH}/rsyslog-gentoo.conf" rsyslog.conf

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/${BRANCH}/rsyslog.logrotate" rsyslog

	newconfd "${FILESDIR}/${BRANCH}/rsyslog.conf" rsyslog
	newinitd "${FILESDIR}/${BRANCH}/rsyslog.init" rsyslog
}
