# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dbmail/dbmail-2.2.11.ebuild,v 1.5 2010/03/28 20:33:23 lordvan Exp $

inherit eutils multilib python

MY_P="${P/_/-}" # for rcX was without the - for versions < 2.2.6
#MY_P="${P}" # releases
DESCRIPTION="A mail storage and retrieval daemon that uses MySQL or PostgreSQL as its data store"
HOMEPAGE="http://www.dbmail.org/"
SRC_URI="http://www.dbmail.org/download/2.2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap mysql postgres sieve sqlite ssl static python"

DEPEND="ssl? ( dev-libs/openssl )
	postgres? ( >=virtual/postgresql-server-7.4 )
	mysql? ( >=virtual/mysql-4.1 )
	sqlite? ( >=dev-db/sqlite-3.0 )
	!mysql? ( !postgres? ( !sqlite? ( >=dev-db/sqlite-3.0 ) ) )
	sieve? ( >=mail-filter/libsieve-2.2.1 )
	ldap? ( >=net-nds/openldap-2.3.33 )
	python? ( net-zope/zope-interface )
	app-text/asciidoc
	app-text/xmlto
	sys-libs/zlib
	=dev-libs/gmime-2.2*
	>=dev-libs/glib-2.8"

S=${WORKDIR}/${P/_/-}

pkg_setup() {
	enewgroup dbmail
	enewuser dbmail -1 -1 /var/lib/dbmail dbmail
}

src_compile() {
	use sqlite && myconf="--with-sqlite"
	if ! use postgres && ! use mysql && ! use sqlite; then myconf="${myconf} --with-sqlite" ; fi
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

	dodoc AUTHORS BUGS ChangeLog README* INSTALL NEWS THANKS UPGRADING VERSION

	docinto sql/mysql
	dodoc sql/mysql/*
	docinto sql/postgresql
	dodoc sql/postgresql/*
	docinto sql/sqlite
	dodoc sql/sqlite/*
	docinto test-scripts
	dodoc test-scripts/*
	docinto contrib/sql2sql
	dodoc contrib/sql2sql
	docinto contrib/mailbox2dbmail
	dodoc contrib/mailbox2dbmail
	docinto contrib
	dodoc contrib/quota_warn.pl

	sed -i -e "s:nobody:dbmail:" dbmail.conf
	sed -i -e "s:nogroup:dbmail:" dbmail.conf
	#sed -i -e "s:#library_directory:library_directory:" dbmail.conf

	insinto /etc/dbmail
	newins dbmail.conf dbmail.conf.dist

	# change config path to our default and use the conf.d and init.d files from the contrib dir
	sed -i -e "s:/etc/dbmail.conf:/etc/dbmail/dbmail.conf:" contrib/startup-scripts/gentoo/init.d-dbmail
	newconfd contrib/startup-scripts/gentoo/conf.d-dbmail dbmail
	newinitd contrib/startup-scripts/gentoo/init.d-dbmail dbmail

	dobin contrib/mailbox2dbmail/mailbox2dbmail
	doman contrib/mailbox2dbmail/mailbox2dbmail.1

	# ldap schema
	if use ldap; then
	   insinto /etc/openldap/schema
	   doins "${S}/dbmail.schema"
	fi

	if use python; then
	   python_version
	   insinto /usr/$(get_libdir)/python${PYVER}/site-packages/dbmail
	   doins python/*.py
	   insinto /usr/$(get_libdir)/python${PYVER}/site-packages/dbmail/app
	   doins python/app/*.py
	   insinto /usr/$(get_libdir)/python${PYVER}/site-packages/dbmail/bin
	   doins python/bin/*.py
	   insinto /usr/$(get_libdir)/python${PYVER}/site-packages/dbmail/lib
	   doins python/lib/*.py
	   insinto /usr/$(get_libdir)/python${PYVER}/site-packages/dbmail/tests
	   doins python/tests/*.py
	fi

	keepdir /var/lib/dbmail
	fperms 750 /var/lib/dbmail

}

pkg_postinst() {
	if use python; then
	   python_version
	   python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/dbmail
	fi
	elog "Please read the INSTALL file in /usr/share/doc/${PF}/"
	elog "for remaining instructions on setting up dbmail users and "
	elog "for finishing configuration to connect to your MTA and "
	elog "to connect to your db."
	echo
	elog "DBMail requires either SQLite, PostgreSQL or MySQL."
	elog "If none of the use-flags are specified SQLite is"
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
	echo
	elog "We are now using the init script from upstream."
	elog "Please edit /etc/conf.d/dbmail to set which services to start"
	elog "and delete /etc/init.d/dbmail-* when you are done. (don't"
	elog "forget to rc-update del dbmail-* first)"
}

pkg_postrm() {
	     python_mod_cleanup
}
