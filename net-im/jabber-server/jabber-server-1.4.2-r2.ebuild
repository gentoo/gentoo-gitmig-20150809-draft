# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabber-server/jabber-server-1.4.2-r2.ebuild,v 1.24 2003/04/25 20:56:36 mholzer Exp $

S="${WORKDIR}/jabber-${PV}"
DESCRIPTION="Open Source Jabber Server & MUC,AIM,MSN,ICQ and Yahoo transports"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://jabberd.jabberstudio.org/downloads/jabber-${PV}.tar.gz
	mirror://gentoo/aim-transport-stable-20021112.tar.gz
	mirror://gentoo/msn-transport-stable-20011217.tar.gz
	http://yahoo-transport.jabberstudio.org/yahoo-t-2.1.1.tar.gz
	mirror://gentoo/Install_AIM_3.5.1670.exe
	http://www.jabberstudio.org/files/mu-conference/muconference-0.3.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="ssl"

DEPEND="=dev-libs/pth-1.4.0
	=dev-libs/glib-1.2*
	ssl? ( >=dev-libs/openssl-0.9.6g )"

src_unpack() {
	unpack jabber-${PV}.tar.gz
	cd ${S}
	patch -p0 < ${FILESDIR}/mio_ssl.c.patch
	unpack msn-transport-stable-20011217.tar.gz
	unpack aim-transport-stable-20021112.tar.gz
	unpack yahoo-t-2.1.1.tar.gz
	unpack muconference-0.3.tar.gz
	mv ${S}/aim-transport-stable-20021012 ${S}/aim-transport
	cd ${S}/aim-transport
	cp ${DISTDIR}/Install_AIM_3.5.1670.exe .

}

src_compile() {
	local myconf
	cd ${S}
	use ssl && myconf="--enable-ssl"

	mv jabberd/jabberd.c jabberd/jabberd.c.orig
	sed 's:pstrdup(jabberd__runtime,HOME):"/var/spool/jabber":' jabberd/jabberd.c.orig > jabberd/jabberd.c
	rm -f jabberd/jabberd.c.orig
	./configure ${myconf} || die 
	make || die

        cd ${S}/aim-transport
	./configure || die 
        make || die
	make install

        cd ${S}/msn-transport
	./bootstrap || die
        ./configure || die
        make || die

	cd ${S}/mu-conference
	make || die 

        cd ${S}/yahoo-transport-2
        make || die

}

src_install() {
        exeinto /etc/init.d ; newexe ${FILESDIR}/jabber.rc6-r1 jabber
        dodir /usr/sbin /etc/jabber /usr/lib/jabber /var/log/jabber
	touch ${D}/var/log/jabber/error.log
	touch ${D}/var/log/jabber/record.log
	dodir /var/spool/jabber
	touch ${D}/var/spool/jabber/.keep
	dodir /var/run

	cp ${S}/jabberd/jabberd ${D}/usr/sbin/
	cp ${S}/aim-transport/src/aimtrans.so ${D}/usr/lib/jabber/
	cp ${S}/aim-transport/Install_AIM_3.5.1670.exe ${D}/usr/lib/jabber/
	cp ${S}/msn-transport/src/msntrans.so ${D}/usr/lib/jabber/
	cp ${S}/mu-conference/src/mu-conference.so ${D}/usr/lib/jabber/
	cp ${S}/yahoo-transport-2/yahoo-transport.so ${D}/usr/lib/jabber/
	cp ${S}/jsm/jsm.so ${D}/usr/lib/jabber/
	cp ${S}/xdb_file/xdb_file.so ${D}/usr/lib/jabber/
	cp ${S}/pthsock/pthsock_client.so ${D}/usr/lib/jabber/
	cp ${S}/dnsrv/dnsrv.so ${D}/usr/lib/jabber/
	cp ${S}/dialback/dialback.so ${D}/usr/lib/jabber/

	cd ${D}/etc/jabber
	tar -xjf ${FILESDIR}/config-1.4.2-r1.tbz2
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
	
	chown jabber.jabber /etc/jabber 
	chown jabber.jabber /usr/sbin/jabberd
	chown jabber.jabber /var/log/jabber -R
	chown jabber.jabber /var/spool/jabber -R
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
	
	einfo "Change 'localhost' to your server's domainname in the /etc/jabber/*.xml configs first"
	einfo "To enable SSL connections, execute /etc/jabber/self-cert.sh"
	einfo "(Only if compiled with SSL support (ssl in USE)"
	einfo "Server admins should be added to the "jabber" group"
}
