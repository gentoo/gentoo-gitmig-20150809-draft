# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-2.0.ebuild,v 1.1 2004/04/08 22:16:18 humpback Exp $

MY_PV="2.0s2"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://www.jabberstudio.org/files/jabberd2/${PN}-${MY_PV}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="ldap ipv6 mysql postgres pam berkdb"

DEPEND="!net-im/jabber-server
	>=dev-libs/openssl-0.9.6i
	ldap? ( >=net-nds/openldap-2.1 )
	berkdb? ( >=sys-libs/db-4.1.25 )
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )"

pkg_setup() {
	if [ ! `use postgres` ] && [ ! `use mysql` ] && [ ! `use berkdb` ];  then
		eerror
		eerror "For this version of jabberd you must have"
		eerror "at least one of 'mysql', 'postgres' and/or 'berkdb'"
		eerror "in the USE variable in /etc/make.conf."
		eerror
		die "Look at the error message above."
	fi
}

src_compile() {
	storage="fs"
	authreg="anon"

	if [ `use db` ]; then
		storage="${storage} db"
		authreg="${authreg} db"
	fi
	if [ `use mysql` ]; then
		storage="${storage} mysql"
		authreg="${authreg} mysql"
	fi
	if [ `use postgres` ]; then
		storage="${myconf} pgsql"
		authreg="${authreg} pgsql"
	fi
	if [ `use pam` ]; then
		authreg="${authreg} pam"
	fi
	if [ `use ldap` ]; then
		authreg="${authreg} ldap"
	fi

	if [ `use ipv6` ]; then
		enables="${enables} --enable-ipv6"
	fi

	cd ${S}


	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-debug \
		--enable-storage="${storage}" \
		--enable-authreg="${authreg}" \
		${enables} || die
	make || die

}

src_install() {
	make DESTDIR=${D} install || die

	exeinto /etc/jabberd
	dodir /var/jabberd
	dodir /var/jabberd/pid
	dodir /var/jabberd/log
	dodir /var/jabberd/db
	touch ${D}/var/jabberd/log/c2s.log
	touch ${D}/var/jabberd/log/resolver.log
	touch ${D}/var/jabberd/log/router.log
	touch ${D}/var/jabberd/log/s2s.log
	touch ${D}/var/jabberd/log/sm.log
	doexe ${FILESDIR}/self-cert.sh
	insinto /etc/conf.d ; newins ${FILESDIR}/jabber-conf.d jabber
	exeinto /etc/init.d ; newexe ${FILESDIR}/jabber.rc6-r7 jabber

	dodoc AUTHORS PROTOCOL README

	docinto tools ; dodoc tools/db-setup.mysql tools/db-setup.pgsql tools/migrate.pl tools/pipe-auth.pl

	local test_group=`grep ^jabber: /etc/group | cut -d: -f1`
	if [ -z $test_group ]
	then
		enewgroup jabber
	fi

	local test_user=`grep ^jabber: /etc/passwd | cut -d: -f1`
	if [ -z $test_user ]
	then
		enewuser jabber -1 /bin/false /var/spool/jabber jabber
	fi

	fowners jabber:jabber /etc/jabberd
	fowners jabber:jabber /etc/jabberd/c2s.xml
	fowners jabber:jabber /etc/jabberd/c2s.xml.dist
	fowners jabber:jabber /etc/jabberd/jabberd.cfg
	fowners jabber:jabber /etc/jabberd/jabberd.cfg.dist
	fowners jabber:jabber /etc/jabberd/resolver.xml
	fowners jabber:jabber /etc/jabberd/resolver.xml.dist
	fowners jabber:jabber /etc/jabberd/router-users.xml
	fowners jabber:jabber /etc/jabberd/router-users.xml.dist
	fowners jabber:jabber /etc/jabberd/router.xml
	fowners jabber:jabber /etc/jabberd/router.xml.dist
	fowners jabber:jabber /etc/jabberd/s2s.xml
	fowners jabber:jabber /etc/jabberd/s2s.xml.dist
	fowners jabber:jabber /etc/jabberd/self-cert.sh
	fowners jabber:jabber /etc/jabberd/sm.xml
	fowners jabber:jabber /etc/jabberd/sm.xml.dist
	fowners jabber:jabber /etc/jabberd/templates

	fowners jabber:jabber /var/jabberd
	fowners jabber:jabber /var/jabberd/db
	fowners jabber:jabber /var/jabberd/log
	fowners jabber:jabber /var/jabberd/pid
	fowners jabber:jabber /var/jabberd/log/c2s.log
	fowners jabber:jabber /var/jabberd/log/resolver.log
	fowners jabber:jabber /var/jabberd/log/router.log
	fowners jabber:jabber /var/jabberd/log/s2s.log
	fowners jabber:jabber /var/jabberd/log/sm.log
	fperms 660 /etc/jabberd/c2s.xml
	fperms 660 /etc/jabberd/c2s.xml.dist
	fperms 660 /etc/jabberd/jabberd.cfg
	fperms 660 /etc/jabberd/jabberd.cfg.dist
	fperms 660 /etc/jabberd/resolver.xml
	fperms 660 /etc/jabberd/resolver.xml.dist
	fperms 660 /etc/jabberd/router-users.xml
	fperms 660 /etc/jabberd/router-users.xml.dist
	fperms 660 /etc/jabberd/router.xml
	fperms 660 /etc/jabberd/router.xml.dist
	fperms 660 /etc/jabberd/s2s.xml
	fperms 660 /etc/jabberd/s2s.xml.dist
	fperms 760 /etc/jabberd/self-cert.sh
	fperms 660 /etc/jabberd/sm.xml
	fperms 660 /etc/jabberd/sm.xml.dist
	fperms 660 /etc/jabberd/templates
	fperms o-rwx /usr/bin/jabberd
}

pkg_postinst() {

	einfo
	einfo "Change 'localhost' to your server's domainname in the"
	einfo "/etc/jabberd/*.xml configs first"
	einfo "Server admins should be added to the "jabber" group"
	if [ `use ssl` ]; then
		einfo
		einfo "To enable SSL connections, execute /etc/jabberd/self-cert.sh"
		einfo
	fi
}
