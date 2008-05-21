# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd2/jabberd2-2.1.23.ebuild,v 1.3 2008/05/21 18:55:11 dev-zero Exp $

inherit db-use eutils flag-o-matic pam

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd2.xiaoka.com/"
SRC_URI="http://ftp.xiaoka.com/${PN}/releases/jabberd-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug memdebug ipv6 ldap mysql pam pipe sasl postgres sqlite"

DEPEND="dev-libs/expat
	dev-libs/openssl
	>=virtual/gsasl-0.2.14
	>=net-dns/libidn-0.6
	ldap? ( net-nds/openldap )
	>=sys-libs/db-4.1.24
	pam? ( virtual/pam )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )
	sqlite? ( >=dev-db/sqlite-3 )"
RDEPEND="${DEPEND}
	>=net-im/jabber-base-0.01
	!net-im/jabberd"

S="${WORKDIR}/jabberd-${PV}"

src_compile() {

	# https://bugs.gentoo.org/show_bug.cgi?id=207655#c3
	replace-flags -O[3s] -O2

	if use debug; then
		localconf="${localconf} --enable-debug"
		# --enable-pool-debug is currently broken
		use memdebug && localconf="${localconf} --enable-nad-debug"
	else
		if use memdebug; then
			ewarn
			ewarn '"memdebug" requires "debug" enabled.'
			ewarn
		fi
	fi

	econf \
		--sysconfdir=/etc/jabber \
		--enable-db \
		--with-extra-include-path=$(db_includedir) \
		${localconf} \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		$(use_enable mysql) \
		$(use_enable pam) \
		$(use_enable pipe) \
		$(use_enable postgres pgsql) \
		$(use_enable sqlite) \
		$(use_with sasl gsasl) \
		|| die "econf failed"
	emake || die "make failed"

}

src_install() {

	make DESTDIR="${D}" install || die "make install failed"

	fowners jabber:jabber /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}
	fperms 750 /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}

	newinitd "${FILESDIR}/jabberd2-${PV}.init" jabberd || die "newinitd failed"
	newpamd "${FILESDIR}/jabberd2-${PV}.pamd" jabberd || die "newpamd failed"

	dodoc AUTHORS BUGS PROTOCOL README UPGRADE
	docinto tools
	dodoc tools/db-setup{.mysql,-status.mysql,.pgsql,.sqlite}
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
