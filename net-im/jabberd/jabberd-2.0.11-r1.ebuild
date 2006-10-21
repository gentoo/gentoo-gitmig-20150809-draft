# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-2.0.11-r1.ebuild,v 1.6 2006/10/21 11:42:20 nelchael Exp $

inherit autotools eutils versionator

MY_PV=$(replace_version_separator 2 s)

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd.jabberstudio.org/2/"
SRC_URI="http://jabberstudio.2nw.net/${PN}2/${PN}-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug memdebug ipv6 ldap mysql pam pipe postgres sqlite ssl"

DEPEND=">=net-im/jabber-base-0.01
	dev-libs/openssl
	net-dns/libidn
	ldap? ( net-nds/openldap )
	>=sys-libs/db-4.1.25
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	sqlite? ( =dev-db/sqlite-3* )
	!=net-im/jabberd-2.0.11"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {

	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-configure.in.patch"

	eautoreconf

}

src_compile() {

	local localconf=
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

	econf \
		--localstatedir=/var \
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
		$(use_enable ssl) \
		|| die "econf failed"
	emake || die "make failed"

}

src_install() {

	make DESTDIR="${D}" install || die "make install failed"

	fowners jabber:jabber /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}
	fperms 750 /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}

	newinitd "${FILESDIR}/jabberd-${PV}.init" jabberd || die "newinitd failed"

	cd "${D}/etc/jabber/"
	sed -i \
		-e 's,/var/jabberd/pid/,/var/run/jabber/,g' \
		-e 's,/var/jabberd/log/,/var/log/jabber/,g' \
		-e 's,/var/jabberd/db,/var/spool/jabber/,g' \
		*.xml *.xml.dist || die "sed failed"
	sed -i \
		-e 's,<module>mysql</module>,<module>db</module>,' \
		c2s.xml*

	dodoc AUTHORS PROTOCOL README
	docinto tools
	for i in db-setup.{mysql,pgsql} migrate.pl pipe-auth.pl; do
		dodoc tools/${i}
	done

}
