# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-2.0.11-r1.ebuild,v 1.1 2006/10/04 20:48:58 nelchael Exp $

inherit autotools versionator

MY_PV=$(replace_version_separator 2 s)

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd.jabberstudio.org/2/"
SRC_URI="http://jabberstudio.2nw.net/${PN}2/${PN}-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="berkdb debug ipv6 ldap mysql pam pipe postgres ssl"

DEPEND="!=net-im/jabberd-2.0.11
	dev-libs/openssl
	net-dns/libidn
	ldap? ( net-nds/openldap )
	berkdb? ( >=sys-libs/db-4.1.25 )
	!mysql? (
		!postgres? ( >=sys-libs/db-4.1.25 )
	)
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"
RDEPEND="${DEPEND}
	dev-lang/perl"

S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup() {

	if ! use postgres && ! use mysql && ! use berkdb; then
		ewarn
		ewarn "For this version of jabberd you should have"
		ewarn "at least one of 'mysql', 'postgres' and/or 'berkdb'"
		ewarn "in the USE variable."
		ewarn
		ewarn "Compiling with default berkdb support."
		ewarn
		ebeep
	fi

}

src_unpack() {

	unpack ${A}
	cd "${S}"

	# Remove substituting $sysconfdir with $sysconfdir/jabberd
	sed -i -e '762s,^,dnl ,' configure.in

}

src_compile() {

	eautoreconf

	local dbengine=
	if ! use postgres && ! use mysql && ! use berkdb; then
		dbengine="--enable-db"
	else
		dbengine="$(use_enable mysql) $(use_enable postgres pgsql) $(use_enable berkdb db)"
	fi

	econf \
		--localstatedir=/var \
		--sysconfdir=/etc/jabber \
		${dbengine} \
		$(use_enable pipe) \
		$(use_enable pam) \
		$(use_enable ldap) \
		$(use_enable ipv6) \
		$(use_enable debug) \
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

	dodoc AUTHORS PROTOCOL README
	docinto tools
	for i in db-setup.{mysql,pgsql} migrate.pl pipe-auth.pl; do
		dodoc tools/${i}
	done

}
