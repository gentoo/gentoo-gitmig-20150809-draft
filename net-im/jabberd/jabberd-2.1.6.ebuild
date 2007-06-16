# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-2.1.6.ebuild,v 1.3 2007/06/16 15:34:02 dertobi123 Exp $

inherit eutils

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd2.xiaoka.com/"
SRC_URI="http://ftp.xiaoka.com/${PN}2/releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug memdebug ipv6 ldap mysql pam pipe postgres sqlite"

DEPEND=">=net-im/jabber-base-0.01
	dev-libs/expat
	dev-libs/openssl
	dev-libs/cyrus-sasl
	net-dns/libidn
	ldap? ( net-nds/openldap )
	>=sys-libs/db-4.1.24
	pam? ( sys-libs/pam )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )
	sqlite? ( >=dev-db/sqlite-3 )
	!<net-im/jabberd-2.0"


src_compile() {

	local localconf=

	# Note: no gsasl support for now, since
	#		gsasl-0.2.14 not in portage tree.
	#
	#if use !gsasl; then
	#	localconf="${localconf} --disable-gsasl --enable-cyrus"
	#fi
	localconf="${localconf} --disable-gsasl --enable-cyrus"

	if use debug; then
		localconf="${localconf} --enable-debug"
		use memdebug && localconf="${localconf} --enable-nad-debug --enable-pool-debug"
	else
		if use memdebug; then
			ewarn
			ewarn '"memdebug" requires "debug" enabled.'
			ewarn
		fi
	fi

	# Fix missing header in subst/strndup.c in order to make emerge
	# happy and avoid QA notice. Should this be moved to a external
	# patch file?
	sed -i "/stddef.h/ a #include <string.h>" subst/strndup.c

	econf \
		--sysconfdir=/etc/jabber \
		--enable-db \
		${localconf} \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		$(use_enable mysql) \
		$(use_enable pam) \
		$(use_enable pipe) \
		$(use_enable postgres pgsql) \
		$(use_enable sqlite) \
		|| die "econf failed"
	emake || die "make failed"

}

src_install() {

	make DESTDIR="${D}" install || die "make install failed"

	fowners jabber:jabber /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}
	fperms 750 /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}

	newinitd "${FILESDIR}/jabberd-${PV}.init" jabberd || die "newinitd failed"

	dodoc AUTHORS BUGS PROTOCOL README UPGRADE
	docinto tools
	for i in db-setup.{mysql,pgsql,sqlite} migrate.pl pipe-auth.pl; do
		dodoc tools/${i}
	done

	cd "${D}/etc/jabber/"
	sed -i \
		-e 's,/var/lib/jabberd/pid/,/var/run/jabber/,g' \
		-e 's,/var/lib/jabberd/log/,/var/log/jabber/,g' \
		-e 's,/var/lib/jabberd/db,/var/spool/jabber/,g' \
		*.xml *.xml.dist || die "sed failed"
	sed -i \
		-e 's,<module>mysql</module>,<module>db</module>,' \
		c2s.xml*
	sed -i \
		-e 's,<driver>mysql</driver>,<driver>db</driver>,' \
		sm.xml*

}
