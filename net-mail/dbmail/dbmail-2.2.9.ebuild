# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dbmail/dbmail-2.2.9.ebuild,v 1.5 2008/05/21 18:57:57 dev-zero Exp $

inherit eutils

MY_P="${P/_/}" # for rcX
#MY_P="${P}" # releases
DESCRIPTION="A mail storage and retrieval daemon that uses MySQL or PostgreSQL as its data store"
HOMEPAGE="http://www.dbmail.org/"
SRC_URI="http://www.dbmail.org/download/2.2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ldap mysql postgres sieve sqlite3 ssl static"

DEPEND="ssl? ( dev-libs/openssl )
	postgres? ( >=virtual/postgresql-server-7.4 )
	mysql? ( >=virtual/mysql-4.1 )
	sqlite3? ( >=dev-db/sqlite-3.0 )
	!mysql? ( !postgres? ( !sqlite3? ( >=dev-db/sqlite-3.0 ) ) )
	sieve? ( >=mail-filter/libsieve-2.2.1 )
	ldap? ( >=net-nds/openldap-2.3.33 )
	app-text/asciidoc
	app-text/xmlto
	sys-libs/zlib
	>=dev-libs/gmime-2.1.18
	>=dev-libs/glib-2.8"

S=${WORKDIR}/${P/_/-}

pkg_setup() {
	enewgroup dbmail
	enewuser dbmail -1 -1 /var/lib/dbmail dbmail
}

src_compile() {
	use sqlite3 && myconf="--with-sqlite"
	use ldap && myconf=${myconf}" --with-auth-ldap"

	econf \
		--sysconfdir=/etc/dbmail \
		${myconf} \
		$(use_enable static) \
		$(use_with sieve) \
		$(use_with ssl) \
		$(use_with postgres pgsql) \
		$(use_with mysql) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS BUGS UPGRADING ChangeLog README* INSTALL* NEWS THANKS
	dodoc sql/mysql/*
	dodoc sql/postgresql/*
	dodoc sql/sqlite/*

	cp dbmail.conf.dist dbmail.conf
	sed -i -e "s:nobody:dbmail:" dbmail.conf
	sed -i -e "s:nogroup:dbmail:" dbmail.conf
	#sed -i -e "s:#library_directory:library_directory:" dbmail.conf
	insinto /etc/dbmail
	newins dbmail.conf dbmail.conf.dist

	newinitd "${FILESDIR}"/dbmail-imapd.initd dbmail-imapd
	newinitd "${FILESDIR}"/dbmail-lmtpd.initd dbmail-lmtpd
	newinitd "${FILESDIR}"/dbmail-pop3d.initd dbmail-pop3d
	use sieve && newinitd "${FILESDIR}"/dbmail-timsieved.initd dbmail-timsieved

	dobin contrib/mailbox2dbmail/mailbox2dbmail
	doman contrib/mailbox2dbmail/mailbox2dbmail.1

	keepdir /var/lib/dbmail
	fperms 750 /var/lib/dbmail

}

pkg_postinst() {
	elog "Please read /usr/share/doc/${PF}/INSTALL.gz"
	elog "for remaining instructions on setting up dbmail users and "
	elog "for finishing configuration to connect to your MTA and "
	elog "to connect to your db."
	echo
	elog "DBMail requires either SQLite3, PostgreSQL or MySQL."
	elog "If none of the use-flags are specified SQLite3 is"
	elog "used as default. To use another database please"
	elog "specify the appropriate use-flag and re-emerge dbmail."
	echo
	elog "Database schemes can be found in /usr/share/doc/${PF}/"
	elog "You will also want to follow the installation instructions"
	elog "on setting up the maintenance program to delete old messages."
	elog "Don't forget to edit /etc/dbmail/dbmail.conf as well."
	echo
	elog "For regular maintenance, add this to crontab:"
	elog "0 3 * * * /usr/bin/dbmail-util -cpdy >/dev/null 2>&1"
	echo
	elog "Please make sure to run etc-update."
	elog "If you get an error message about plugins not found"
	elog "please add the library_directory configuration switch to"
	elog "dbmail.conf and set it to the correct path"
	elog "(usually /usr/lib/dbmail or /usr/lib64/dbmail on amd64)"
	elog "A sample can be found in dbmail.conf.dist after etc-update."
}
