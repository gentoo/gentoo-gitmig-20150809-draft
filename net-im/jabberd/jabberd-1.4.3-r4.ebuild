# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-1.4.3-r4.ebuild,v 1.7 2005/03/25 10:45:19 kloeri Exp $

inherit eutils

S="${WORKDIR}/jabberd-${PV}"
DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://jabberd.jabberstudio.org/1.4/dist/jabberd-${PV}.tar.gz
	http://www.gentoo-pt.org/~humpback/jabberd-1.4.3-extexpat.diff
	ldap? ( http://www.jabberstudio.org/files/xdb_ldap/xdb_ldap-1.0.tar.gz )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc hppa ~sparc ~amd64 ~alpha"
IUSE="ssl ldap ipv6 msn oscar yahoo icq"

DEPEND="!net-im/jabber-server
	>=dev-libs/pth-1.4.0
	dev-libs/expat
	ssl? ( >=dev-libs/openssl-0.9.6i )
	ldap? ( =net-nds/openldap-2* )"

PDEPEND="msn? ( net-im/msn-transport )
		 oscar? ( net-im/aim-transport )
		 yahoo? ( net-im/yahoo-transport )
		 icq? ( net-im/jit )"

pkg_setup() {

	if use ipv6 ; then
		ewarn "You are about to build with ipv6 support, if your system is not using ipv6"
		ewarn "do control-c now and emerge with \"USE=-ipv6\" "
		epause 5
	fi
}

src_unpack() {
	unpack jabberd-${PV}.tar.gz
	cd ${S}
	use ldap	&& unpack xdb_ldap-1.0.tar.gz
	epatch ${FILESDIR}/multiple-xml-patch-00
	epatch ${FILESDIR}/multiple-xml-patch-01
	#Patch for extexpat DoS http://www.jabber.org/pipermail/jadmin/2004-September/018046.html
	epatch ${DISTDIR}/jabberd-1.4.3-extexpat.diff
	mv jabber.xml multiple.xml
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
	insinto /etc/conf.d ; newins ${FILESDIR}/jabber-conf.d jabber
	exeinto /etc/init.d ; newexe ${FILESDIR}/jabber.rc6-r7 jabber
	dodir /usr/sbin /etc/jabber /usr/lib/jabberd /var/log/jabber /usr/include/jabberd
	touch ${D}/var/log/jabber/error.log
	touch ${D}/var/log/jabber/record.log
	dodir /var/spool/jabber
	keepdir /var/spool/jabber/
	keepdir /var/log/jabber/
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
	if use ldap; then
		insinto /etc/jabber
		doins xdb_ldap/jabber.schema
		doins xdb_ldap/slapd.conf
		doins config/xdb-ldap.xml
		insinto /usr/lib/jabberd
		doins xdb_ldap/src/xdb_ldap.so
	fi
	insinto /etc/jabber
	doins multiple.xml
	exeinto /etc/jabber
	doexe ${FILESDIR}/self-cert.sh

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

	dodoc README UPGRADE ${FILESDIR}/README.Gentoo

	fowners jabber:jabber /etc/jabber
	fowners jabber:jabber /usr/sbin/jabberd
	fowners jabber:jabber /var/log/jabber
	fowners jabber:jabber /var/log/jabber/error.log
	fowners jabber:jabber /var/log/jabber/record.log
	fowners jabber:jabber /var/spool/jabber

	fperms o-rwx /etc/jabber
	fperms o-rwx /usr/sbin/jabberd
	fperms o-rwx /var/log/jabber
	fperms o-rwx /var/log/jabber/error.log
	fperms o-rwx /var/log/jabber/record.log
	fperms o-rwx /var/spool/jabber
	fperms u+rwx /usr/sbin/jabberd

	fperms g-x /etc/jabber
	fperms g-x /usr/sbin/jabberd
	fperms g-x /var/log/jabber
	fperms g-x /var/log/jabber/error.log
	fperms g-x /var/log/jabber/record.log
	fperms g-x /var/spool/jabber

	fperms g+rw /etc/jabber
	fperms g+rw /usr/sbin/jabberd
	fperms g+rw /var/log/jabber
	fperms g+rw /var/log/jabber/error.log
	fperms g+rw /var/log/jabber/record.log
	fperms g+rw /var/spool/jabber
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
	if use ssl; then
		einfo
		einfo "To enable SSL connections, execute /etc/jabber/self-cert.sh"
	fi
	if use ldap; then
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
	einfo "The various IM transports for jabber are now separate packages,"
	einfo "which you will need to install separately if you want them:"
	einfo "net-im/jit - ICQ transport (You can use aim-transport for icq but JIT is better)"
	einfo "net-im/msn-transport - MSN transport (USE=msn)"
	einfo "net-im/jud - Jabber User Directory"
	einfo "net-im/yahoo-transport - Yahoo IM system (USE=yahoo)"
	einfo "net-im/aim-transport - AOL transport (USE=oscar)"
	einfo "net-im/mu-conference - Jabber multi user conference"
	einfo
	einfo "Please read /usr/share/doc/${PF}/README.Gentoo.gz"
	einfo
	ewarn "If upgrading from older version please stop jabberd BEFORE updating the init.d"
	ewarn "script, or you will end with a \"dead\" server."
}
