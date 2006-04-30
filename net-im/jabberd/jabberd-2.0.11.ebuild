# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-2.0.11.ebuild,v 1.1 2006/04/30 13:50:43 reb Exp $

inherit eutils

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd.jabberstudio.org/2/"
MY_P="${PN}-2.0s11"
SRC_URI="http://jabberstudio.2nw.net/jabberd2/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="debug ldap ipv6 mysql postgres pam berkdb ssl"

DEPEND="!net-im/jabber-server
	>=dev-libs/openssl-0.9.6i
	>=net-dns/libidn-0.3.5
	ldap? ( >=net-nds/openldap-2.1 )
	berkdb? ( >=sys-libs/db-4.1.25 )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"
RDEPEND="${DEPEND}
	dev-lang/perl" # for the /usr/bin/jabberd wrapper script

pkg_setup() {
	if ! use postgres && ! use mysql && ! use berkdb;  then
		eerror
		eerror "For this version of jabberd you must have"
		eerror "at least one of 'mysql', 'postgres' and/or 'berkdb'"
		eerror "in the USE variable in /etc/make.conf."
		eerror
		die "Look at the error message above."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	local myopts="--enable-fs"
	useq berkdb && myopts="${myopts} --enable-db"
	useq mysql && myopts="${myopts} --enable-mysql" || myopts="${myopts} --disable-mysql"
	useq postgres && myopts="${myopts} --enable-pgsql"
	useq pam && myopts="${myopts} --enable-pam"
	useq ldap && myopts="${myopts} --enable-ldap"
	useq ipv6 && myopts="${myopts} --enable-ipv6"
	useq debug && myopts="${myopts} --enable-debug"

	econf ${myopts} --localstatedir=/var || die "configure failed"
	emake || die "make failed"
}

src_install() {
#	DON'T USE EINSTALL HERE! it breaks the Makefile's sysconfdir!
#	einstall || die "make install failed"
	make DESTDIR=${D} install || die "make install failed"

	## add user and group
	enewgroup jabber
	enewuser jabber -1 -1 /var/jabberd jabber

	## set binary permissions
	fowners :jabber /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}
	fperms o= /usr/bin/{jabberd,router,resolver,sm,c2s,s2s}

	## jabberd working directory
	dodir /var/jabberd{,/{db,log,pid}}
	fowners jabber:jabber /var/jabberd{,/{db,log,pid}}
	for i in router resolver sm c2s s2s; do
		for j in log pid; do
			touch ${D}/var/jabberd/${j}/${i}.${j}
			fowners jabber:jabber /var/jabberd/${j}/${i}.${j}
		done
	done

	#ä jabberd config & init script
	exeinto /etc/init.d; newexe ${FILESDIR}/jabber.init.bundled jabber
#	exeinto /etc/init.d; newexe ${FILESDIR}/jabber.init.gentoo jabber
	exeinto /etc/jabberd; newexe ${FILESDIR}/self-cert.jabberd-2.sh self-cert.sh
	# directories
	fowners jabber:jabber /etc/jabberd{,/templates}
	fperms 770 /etc/jabberd{,/templates}
	# ssl script
	fowners jabber:jabber /etc/jabberd/self-cert.sh
	fperms 770 /etc/jabberd/self-cert.sh
	# config files
	for i in jabberd.cfg {router,router-users,resolver,sm,c2s,s2s,templates/roster}.xml; do
		fowners jabber:jabber /etc/jabberd/${i}{,.dist}
		fperms 660 /etc/jabberd/${i}{,.dist}
	done

	## documentation
	dodoc AUTHORS PROTOCOL README
	docinto tools
	for i in db-setup.{mysql,pgsql} migrate.pl pipe-auth.pl; do
		dodoc tools/${i}
	done
}

pkg_postinst() {
	einfo
	einfo "Change 'localhost' to your server's domainname in the"
	einfo "/etc/jabberd/*.xml configs first"
	einfo "Server admins should be added to the 'jabber' group"
	if use ssl; then
		einfo
		einfo "To enable SSL connections, execute /etc/jabberd/self-cert.sh"
	fi
	einfo
}
