# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabber-server/jabber-server-1.4.3-r1.ebuild,v 1.4 2004/01/15 04:00:34 agriffis Exp $

S="${WORKDIR}/jabberd-${PV}"
DESCRIPTION="Open Source Jabber Server & JUD,MUC,AIM,MSN,ICQ and Yahoo transports"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://jabberd.jabberstudio.org/1.4/dist/jabberd-${PV}.tar.gz
	!j-noaim? ( mirror://gentoo/aim-transport-stable-20030314.tar.gz
	http://ftp.newaol.com/aim/win95/Install_AIM.exe )
	!j-nomsn? ( http://msn-transport.jabberstudio.org/msn-transport-1.2.8pre5.tar.gz )
	!j-noyahoo? (http://yahoo-transport.jabberstudio.org/yahoo-t-2.1.1.tar.gz )
	!j-nomuconf? ( http://www.jabberstudio.org/files/mu-conference/mu-conference-0.5.1.tar.gz )
	ldap? ( http://www.jabberstudio.org/files/xdb_ldap/xdb_ldap-1.0.tar.gz )
	!j-nojud? ( http://jud.jabberstudio.org/jud-0.5.tar.gz )"
#mirror://gentoo/Install_AIM_3.5.1670.exe

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"
IUSE="ssl ldap ipv6"
# Internal USE flags that I do not really want to advertise ...
IUSE="${IUSE} j-nomsn j-noaim j-noyahoo j-nomuconf j-nojud"

DEPEND="=dev-libs/pth-1.4.0
	!j-noyahoo? ( =dev-libs/glib-1.2* !=sys-libs/glibc-2.3.1 )
	ssl? ( >=dev-libs/openssl-0.9.6i )
	ldap? ( =net-nds/openldap-2* )
	!j-nomsn? ( !=sys-libs/glibc-2.3.1 net-ftp/curl )
	!j-noaim? ( !=sys-libs/glibc-2.3.1 )
	!j-nomuconf? ( !=sys-libs/glibc-2.3.1 )
	!j-nojud? ( !=sys-libs/glibc-2.3.1 )"

src_unpack() {
	unpack jabberd-${PV}.tar.gz
	cd ${S}
	if ! use j-nomsn; then
		unpack msn-transport-1.2.8pre5.tar.gz
		cd msn-transport*
		epatch ${FILESDIR}/msn-configure-patch-00
		cd ..
	fi
	use j-noyahoo	|| unpack yahoo-t-2.1.1.tar.gz
	use j-nojud	|| unpack jud-0.5.tar.gz
	use ldap	&& unpack xdb_ldap-1.0.tar.gz
	if ! use j-nomuconf; then
		unpack mu-conference-0.5.1.tar.gz
		mv ${S}/mu-conference-0.5.1 ${S}/mu-conference
	fi
	if ! use j-noaim; then
		unpack aim-transport-stable-20030314.tar.gz
		mv ${S}/aim-transport-stable-20030314 ${S}/aim-transport
		cd ${S}/aim-transport
		cp ${DISTDIR}/Install_AIM.exe .
	fi

	mkdir ${S}/config -p
	cd ${S}/config
	tar -xjf ${FILESDIR}/config-1.4.2-r4.tbz2
}

src_compile() {
	# These can cause problems with certain configure scripts used...
	unset LC_ALL LC_CTYPE


	local myconf=""
	cd ${S}
	use ssl && myconf="$myconf --enable-ssl"
	use ipv6 && myconf="$myconf --enable-ipv6"

	mv jabberd/jabberd.c jabberd/jabberd.c.orig
	sed 's:pstrdup(jabberd__runtime,HOME):"/var/spool/jabber":' jabberd/jabberd.c.orig > jabberd/jabberd.c
	rm -f jabberd/jabberd.c.orig
	./configure ${myconf} || die
	make || die

	if ! use j-noaim; then
	        cd ${S}/aim-transport
		./configure || die
	        make || die
		make install
	fi

	if ! use j-nomsn; then
		cd ${S}/msn-transport*
		./configure --with-jabberd=${S}/jabberd || die
		make || die
	fi

	if ! use j-nomuconf; then
		cd ${S}/mu-conference
		make || die
	fi

	if ! use j-nojud; then
		cd ${S}/jud-ansi-c
		make || die
	fi

	if ! use j-noyahoo; then
		cd ${S}/yahoo-transport-2
		make || die
	fi

	if use ldap; then
		cd ${S}/xdb_ldap/src
		make all || die
	fi
}

src_install() {
	exeinto /etc/init.d ; newexe ${FILESDIR}/jabber.rc6-r3 jabber
	dodir /usr/sbin /etc/jabber /usr/lib/jabber /var/log/jabber
	touch ${D}/var/log/jabber/error.log
	touch ${D}/var/log/jabber/record.log
	keepdir /var/spool/jabber
	dodir /var/run

	cp ${S}/jabberd/jabberd ${D}/usr/sbin/
	if ! use j-noaim; then
		cp ${S}/aim-transport/src/aimtrans.so ${D}/usr/lib/jabber/
		cp ${S}/aim-transport/Install_AIM.exe ${D}/usr/lib/jabber/
		cp ${S}/config/aimtrans.xml ${D}/etc/jabber/
		cp ${S}/config/icqtrans.xml ${D}/etc/jabber/
	fi
	if ! use j-nomsn; then
		cp ${S}/msn-transport*/src/msntrans.so ${D}/usr/lib/jabber/
		cp ${S}/config/msntrans.xml ${D}/etc/jabber/
	fi
	if ! use j-nomuconf; then
		cp ${S}/mu-conference/src/mu-conference.so ${D}/usr/lib/jabber/
		cp ${S}/config/muctrans.xml ${D}/etc/jabber/
	fi
	if ! use j-nojud; then
		cp ${S}/jud-ansi-c/jud.so ${D}/usr/lib/jabber/
		cp ${S}/jud-ansi-c/README ${D}/etc/jabber/jud.README
	fi
	if ! use j-noyahoo; then
		cp ${S}/yahoo-transport-2/yahoo-transport.so ${D}/usr/lib/jabber/
		cp ${S}/config/yahootrans.xml ${D}/etc/jabber/
	fi
	cp ${S}/jsm/jsm.so ${D}/usr/lib/jabber/
	cp ${S}/xdb_file/xdb_file.so ${D}/usr/lib/jabber/
	cp ${S}/pthsock/pthsock_client.so ${D}/usr/lib/jabber/
	cp ${S}/dnsrv/dnsrv.so ${D}/usr/lib/jabber/
	cp ${S}/dialback/dialback.so ${D}/usr/lib/jabber/
	if use ldap; then
		cp ${S}/xdb_ldap/jabber.schema ${D}/etc/jabber/
		cp ${S}/xdb_ldap/slapd.conf ${D}/etc/jabber/
		cp ${S}/xdb_ldap/src/xdb_ldap.so ${D}/usr/lib/jabber/
		cp ${S}/config/xdb-ldap.xml ${D}/etc/jabber/
	fi
	if use j-noaim; then
		grep -v 'aim data' ${S}/config/multiple.xml > ${S}/config/multiple.xml.new
		mv ${S}/config/multiple.xml.new ${S}/config/multiple.xml
	fi; if use j-nomsn; then
		grep -v 'msn data' ${S}/config/multiple.xml > ${S}/config/multiple.xml.new
		mv ${S}/config/multiple.xml.new ${S}/config/multiple.xml
	fi; if use j-noyahoo; then
		grep -v 'yahoo data' ${S}/config/multiple.xml > ${S}/config/multiple.xml.new
		mv ${S}/config/multiple.xml.new ${S}/config/multiple.xml
	fi; if use j-nomuconf; then
		grep -v 'muconf data' ${S}/config/multiple.xml > ${S}/config/multiple.xml.new
		mv ${S}/config/multiple.xml.new ${S}/config/multiple.xml
	fi; if use j-nojud; then
		grep -v 'jud data' ${S}/config/multiple.xml > ${S}/config/multiple.xml
		mv ${S}/config/multiple.xml.new ${S}/config/multiple.xml
	fi
	cp ${S}/config/multiple.xml ${D}/etc/jabber/
}

pkg_postinst() {
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

	chown jabber:jabber /etc/jabber
	chown jabber:jabber /usr/sbin/jabberd
	chown jabber:jabber /var/log/jabber -R
	chown jabber:jabber /var/spool/jabber -R
	chmod o-rwx /etc/jabber
	chmod o-rwx /usr/sbin/jabberd
	chmod o-rwx /var/log/jabber -R
	chmod o-rwx /var/spool/jabber -R
	chmod u+rwx /usr/sbin/jabberd
	chmod g-x /etc/jabber
	chmod g-x /usr/sbin/jabberd
	chmod g-x /var/log/jabber -R
	chmod g-x /var/spool/jabber -R
	chmod g+rw /etc/jabber
	chmod g+rw /usr/sbin/jabberd
	chmod g+rw /var/spool/jabber -R
	chmod g+rw /var/log/jabber -R
	chmod u+xs /usr/sbin/jabberd

	einfo "Change 'localhost' to your server's domainname in the"
	einfo "/etc/jabber/*.xml configs first"
	if use ssl >/dev/null; then
		einfo "To enable SSL connections, execute /etc/jabber/self-cert.sh"
	fi
	einfo "Server admins should be added to the "jabber" group"
	if use ldap >/dev/null; then
		einfo "In order to use the ldap backend, you need to copy"
		einfo "the file /etc/jabber/jabber.schema into the /etc/openldap/schemas"
		einfo "directory on your ldap server. You will also need to"
		einfo "include the schema in your slapd.conf file and retsart openldap."
		einfo "An example slapd.conf file is included in /etc/jabber."
		einfo "The xdb_ldap backend expects your ldap server to handle"
		einfo "StartTLS or run in ldaps mode."
	fi
	if ! use j-nojud >/dev/null; then
		einfo "To complete JUD configuration, read /etc/jabber/jud.README"
	fi
}
