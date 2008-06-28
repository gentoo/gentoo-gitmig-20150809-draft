# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd2/jabberd2-2.2.0-r1.ebuild,v 1.1 2008/06/28 11:24:35 gentoofan23 Exp $

inherit db-use eutils flag-o-matic pam

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd2.xiaoka.com/"
SRC_URI="http://ftp.xiaoka.com/${PN}/releases/jabberd-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="berkdb debug memdebug mysql ldap pam pipe postgres sqlite ssl zlib"

DEPEND="dev-libs/expat
	zlib? ( sys-libs/zlib )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	net-libs/udns
	>=net-dns/libidn-0.3
	ldap? ( net-nds/openldap )
	berkdb? ( >=sys-libs/db-4.1.24 )
	pam? ( virtual/pam )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	sqlite? ( >=dev-db/sqlite-3 )
	>=virtual/gsasl-0.2.26"
RDEPEND="${DEPEND}
	>=net-im/jabber-base-0.01
	!net-im/jabberd"

S="${WORKDIR}/jabberd-${PV}"

pkg_setup() {
	if ! use berkdb && ! use postgres && ! use mysql && ! use sqlite; then
		eerror 'You have no storage backend selected.'
		eerror 'Please set one of the following USE flags:'
		eerror '    berkdb'
		eerror '    postgres'
		eerror '    mysql'
		eerror '    sqlite'
		die 'Please enable one of the storage backends mentioned.'
	fi

	if ! use berkdb && ! use mysql && ! use postgres \
	&& ! use pam && ! use ldap; then
		eerror 'You have no Authentication mechanism selected.'
		eerror 'Please set one of the following USE flags for authentication:'
		eerror '    berkdb'
		eerror '    mysql'
		eerror '    postgres'
		eerror '    pam'
		eerror '    ldap'
		die 'Please enable one of the authentication mechanisms mentioned.'
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-apr_base64.patch
}

src_compile() {

	# https://bugs.gentoo.org/show_bug.cgi?id=207655#c3
	replace-flags -O[3s] -O2

	use berkdb && myconf="${myconf} --with-extra-include-path=$(db_includedir)"

	if use debug; then
		myconf="${myconf} --enable-debug"
		# --enable-pool-debug is currently broken
		use memdebug && myconf="${myconf} --enable-nad-debug"
	else
		if use memdebug; then
			ewarn
			ewarn '"memdebug" requires "debug" enabled.'
			ewarn
		fi
	fi

	econf \
		--sysconfdir=/etc/jabber \
		${myconf} \
		$(use_enable berkdb db)
		$(use_enable ldap) \
		$(use_enable mysql) \
		$(use_enable pam) \
		$(use_enable pipe) \
		$(use_enable postgres pgsql) \
		$(use_enable sqlite) \
		$(use_enable ssl) \
		$(use_with zlib)
	emake || die "make failed"

}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	fowners jabber:jabber /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}
	fperms 750 /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}

	newinitd "${FILESDIR}/${P}.init" jabberd || die "newinitd failed"
	newpamd "${FILESDIR}/${P}.pamd" jabberd || die "newpamd failed"

	dodoc AUTHORS README UPGRADE
	docinto tools
	dodoc tools/db-setup{.mysql,.pgsql,.sqlite}
	dodoc tools/{migrate.pl,pipe-auth.pl}

	cd "${D}/etc/jabber/"
	sed -i \
		-e 's,/var/lib/jabberd/pid/,/var/run/jabber/,g' \
		-e 's,/var/lib/jabberd/log/,/var/log/jabber/,g' \
		-e 's,/var/lib/jabberd/db,/var/spool/jabber/,g' \
		*.xml *.xml.dist || die "sed failed"
	sed -i \
		-e 's,<module>mysql</module>,<module>db</module>,' \
		c2s.xml* || die "sed failed"
	sed -i \
		-e 's,<driver>mysql</driver>,<driver>db</driver>,' \
		sm.xml* || die "sed failed"

}

pkg_postinst() {

	if use pam; then
		echo
		ewarn 'Jabberd-2 PAM authentication requires your unix usernames to'
		ewarn 'be in the form of "contactname@jabberdomain". This behavior'
		ewarn 'is likely to change in future versions of jabberd-2. It may'
		ewarn 'be advisable to avoid PAM authentication for the time being.'
		echo
		ebeep
	fi

}
