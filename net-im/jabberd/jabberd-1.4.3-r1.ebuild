# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-1.4.3-r1.ebuild,v 1.2 2004/01/23 19:20:39 humpback Exp $

S="${WORKDIR}/jabberd-${PV}"
DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://jabberd.jabberstudio.org/1.4/dist/jabberd-${PV}.tar.gz
	ldap? ( http://www.jabberstudio.org/files/xdb_ldap/xdb_ldap-1.0.tar.gz )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="ssl ldap ipv6"

DEPEND="!net-im/jabber-server
	=dev-libs/pth-1.4.0
	ssl? ( >=dev-libs/openssl-0.9.6i )
	ldap? ( =net-nds/openldap-2* )"

src_unpack() {
	unpack jabberd-${PV}.tar.gz
	cd ${S}
	use ldap	&& unpack xdb_ldap-1.0.tar.gz

}

src_compile() {
	# These can cause problems with certain configure scripts used...
	unset LC_ALL LC_CTYPE


	local myconf
	cd ${S}
	use ssl && myconf="--enable-ssl"
	use ipv6 && myconf="${myconf} --enable-ipv6"

	mv jabberd/jabberd.c jabberd/jabberd.c.orig
	sed 's:pstrdup(jabberd__runtime,HOME):"/var/spool/jabber":' jabberd/jabberd.c.orig > jabberd/jabberd.c
	rm -f jabberd/jabberd.c.orig
	./configure ${myconf} || die
	make || die

	if use ldap; then
		cd ${S}/xdb_ldap/src
		make all || die
	fi
}

src_install() {
	exeinto /etc/init.d ; newexe ${FILESDIR}/jabber.rc6-r5 jabber
	dodir /usr/sbin /etc/jabber /usr/lib/jabberd /var/log/jabber /usr/include/jabberd
	touch ${D}/var/log/jabber/error.log
	touch ${D}/var/log/jabber/record.log
	dodir /var/spool/jabber
	touch ${D}/var/spool/jabber/.keep
	dodir /var/run

	exeinto /usr/sbin
	doexe jabberd/jabberd
	insinto /usr/lib/jabberd
	doins platform-settings
	doins jsm/jsm.so
	doins xdb_file/xdb_file.so
	doins pthsock/pthsock_client.so
	doins dnsrv/dnsrv.so
	doins dialback/dialback.so
	if [ `use ldap` ]; then
		insinto /etc/jabber
		doins xdb_ldap/jabber.schema
		doins xdb_ldap/slapd.conf
		doins config/xdb-ldap.xml
		insinto /usr/lib/jabberd
		doins xdb_ldap/src/xdb_ldap.so
	fi
	insinto /etc/jabber
	doins ${FILESDIR}/multiple.xml
	exeinto /etc/jabber
	doexe ${FILESDIR}/self-cert.sh

	local test_group=`grep ^jabber: /etc/group | cut -d: -f1`
	if [ -z $test_group ]
	then
		groupadd jabber
	fi

	local test_user=`grep ^jabber: /etc/passwd | cut -d: -f1`
	if [ -z $test_user ]
	then
		useradd jabber -s /bin/false -d /var/spool/jabber -g jabber -m
	fi

	dodoc README UPGRADE ${FILESDIR}/README.Gentoo

	fowners jabber:jabber /etc/jabber
	fowners jabber:jabber /usr/sbin/jabberd
	fowners jabber:jabber /var/log/jabber
	fowners jabber:jabber /var/log/jabber/error.log
	fowners jabber:jabber /var/log/jabber/record.log
	fowners jabber:jabber /var/spool/jabber
	fowners jabber:jabber /var/spool/jabber/.keep

	fperms o-rwx /etc/jabber
	fperms o-rwx /usr/sbin/jabberd
	fperms o-rwx /var/log/jabber
	fperms o-rwx /var/log/jabber/error.log
	fperms o-rwx /var/log/jabber/record.log
	fperms o-rwx /var/spool/jabber
	fperms o-rwx /var/spool/jabber/.keep
	fperms u+rwx /usr/sbin/jabberd

	fperms g-x /etc/jabber
	fperms g-x /usr/sbin/jabberd
	fperms g-x /var/log/jabber
	fperms g-x /var/log/jabber/error.log
	fperms g-x /var/log/jabber/record.log
	fperms g-x /var/spool/jabber
	fperms g-x /var/spool/jabber/.keep

	fperms g+rw /etc/jabber
	fperms g+rw /usr/sbin/jabberd
	fperms g+rw /var/spool/jabber
	fperms g+rw /var/spool/jabber/error.log
	fperms g+rw /var/spool/jabber/record.log
	fperms g+rw /var/log/jabber
	fperms g+rw /var/log/jabber/.keep
	fperms u+xs /usr/sbin/jabberd

	#Install header files for transports to use
	cd ${S}/jabberd
	tar cf - `find . -name \*.h` | (cd ${D}/usr/include/jabberd ; tar xvf -)
	assert "Failed to install header files to /usr/include/jabberd"
}

pkg_postinst() {

	einfo
	einfo "Change 'localhost' to your server's domainname in the"
	einfo "/etc/jabber/*.xml configs first"
	einfo "Server admins should be added to the "jabber" group"
	if [ `use ssl` ]; then
		einfo
		einfo "To enable SSL connections, execute /etc/jabber/self-cert.sh"
	fi
	if [ `use ldap` ]; then
		einfo
		einfo "In order to use the ldap backend, you need to copy"
		einfo "the file /etc/jabber/jabber.schema into the /etc/openldap/schemas"
		einfo "directory on your ldap server. You will also need to"
		einfo "include the schema in your slapd.conf file and retsart openldap."
		einfo "An example slapd.conf file is included in /etc/jabber."
		einfo "The xdb_ldap backend expects your ldap server to handle"
		einfo "StartTLS or run in ldaps mode."
	fi
	einfo
	einfo "Please read /usr/share/doc/${P}/README.Gentoo.gz"
	einfo
}
