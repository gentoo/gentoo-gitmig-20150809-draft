# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabber-server/jabber-server-1.4.2-r1.ebuild,v 1.3 2002/07/17 09:08:08 seemant Exp $

S="${WORKDIR}/jabber-${PV}"
DESCRIPTION="Open Source Jabber Server & JUD,AIM,MSN,ICQ,Yahoo and Conference transports"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://jabberd.jabberstudio.org/downloads/jabber-${PV}.tar.gz
	 http://jabberd.jabberstudio.org/downloads/conference-0.4.tar.gz	
	 http://jabberd.jabberstudio.org/downloads/jud-0.4.tar.gz
	 http://www.ibiblio.org/gentoo/distfiles/aim-transport-stable-20020503.tar.gz
         http://www.ibiblio.org/gentoo/distfiles/msn-transport-stable-20011217.tar.gz
         http://www.ibiblio.org/gentoo/distfiles/yahoo-transport-0.8.4.6.tar.gz
	 http://www.ibiblio.org/gentoo/distfiles/Install_AIM_3.5.1670.exe"

DEPEND=">=dev-libs/pth-1.4.0
	ssl? ( >=dev-libs/openssl-0.9.6c )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {

	unpack jabber-${PV}.tar.gz
	cd ${S}
	tar -xjf ${FILESDIR}/config-1.4.2.tar.bz2
	unpack msn-transport-stable-20011217.tar.gz
	unpack aim-transport-stable-20020503.tar.gz
	unpack conference-0.4.tar.gz
	unpack jud-0.4.tar.gz
	unpack yahoo-transport-0.8.4.6.tar.gz
	cd ${S}/aim-transport
	cp ${DISTDIR}/Install_AIM_3.5.1670.exe .

}

src_compile() {

	local myconf
	cd ${S}
	use ssl && myconf="--enable-ssl"

	mv jabberd/jabberd.c jabberd/jabberd.c.orig
	sed 's:pstrdup(jabberd__runtime,HOME):"/usr/jabber-1.4.2":' jabberd/jabberd.c.orig > jabberd/jabberd.c
	rm -f jabberd/jabberd.c.orig
	./configure ${myconf} || die
	make || die

        cd ${S}/conference-0.4
        make || die

        cd ${S}/jud-0.4
        make || die

        cd ${S}/aim-transport
	./autogen.sh || die
        make || die

        cd ${S}/msn-transport
        ./bootstrap || die
	./configure || die
	make || die

        cd ${S}/yahoo-transport
	CPPFLAGS="$CPPFLAGS -I../jabberd -I../../jabberd" ./autogen.sh || die
	make || die

}


src_install() {

        cd ${S}
	touch error.log
	touch record.log
        exeinto /etc/init.d ; newexe ${FILESDIR}/jabber.rc6 jabber
        mkdir -p ${D}/usr/jabber-${PV}
        cp -rf * ${D}/usr/jabber-${PV}/
	cd ${D}/usr/jabber-${PV}/jabberd

}

pkg_postinst() {

	cd /usr/jabber-${PV}
	groupadd jabber
	useradd jabber -s /bin/false -d /usr/jabber-${PV} -g jabber -m	
	chown jabber.jabber * -R
	chmod o-rwx * -R
	chmod g-x * -R
	chmod g+rw * -R
	chmod u+xs jabberd/jabberd
	
	einfo "Change 'localhost' to your server's domainname in the *.xml configs first"
	einfo "To enable SSL connections, execute ./self-cert.sh in the server's dir"
	einfo "(Only if compiled with SSL support (ssl in USE)"
	einfo "Server admins should be added to the "jabber" group"

}

pkg_postrm() {

	userdel jabber
	groupdel jabber

}
