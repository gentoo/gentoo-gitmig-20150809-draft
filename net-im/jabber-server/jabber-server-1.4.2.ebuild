# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/jabber-server/jabber-server-1.4.2.ebuild,v 1.3 2002/02/13 21:11:00 verwilst Exp $

S="${WORKDIR}/jabber-${PV}"
DESCRIPTION="Open Source Jabber Server & AIM,MSN,ICQ,Yahoo en conference transports"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://download.jabber.org/stable/jabber-${PV}.tar.gz
	 http://download.jabber.org/dists/transports/aim-transport/aim-transport-0.9.24c.tar.gz
         http://download.jabber.org/dists/1.4/final/conference-0.4.1.tar.gz
         http://download.jabber.org/dists/transports/irc-transport/irc-transport-0.1.1-1.4.linux.tar.gz
         http://download.jabber.org/dists/1.4/final/jud-0.4.tar.gz
         http://download.jabber.org/dists/1.4/final/msn-transport-1.1.tar.gz
         http://download.jabber.org/dists/1.4/final/yahoo-transport-0.8-1.4.linux.tar.gz"

DEPEND="virtual/glibc
	>=dev-libs/pth-1.4.0
	ssl? ( >=dev-libs/openssl-0.9.6c )"

src_unpack() {

	unpack jabber-${PV}.tar.gz
	cd ${S}
	unpack msn-transport-1.1.tar.gz
	unpack aim-transport-0.9.24c.tar.gz
	unpack conference-0.4.1.tar.gz
	unpack irc-transport-0.1.1-1.4.linux.tar.gz
	unpack jud-0.4.tar.gz
	unpack yahoo-transport-0.8-1.4.linux.tar.gz

}

src_compile() {
	
	cd ${S}
	if [ "`use ssl`" ] ; then
		mv configure configure.orig
		sed 's:WANT_SSL=0:WANT_SSL=1:' configure.orig > configure
		rm -f configure.orig
		chmod 750 configure
	fi
	mv jabberd/jabberd.c jabberd/jabberd.c.orig
	sed 's:pstrdup(jabberd__runtime,HOME):"/usr/jabber-1.4.2":' jabberd/jabberd.c.orig > jabberd/jabberd.c
	rm -f jabberd/jabberd.c.orig
	./configure || die
	make || die

        cd ${S}/conference-0.4.1
        make || die

        cd ${S}/jud-0.4
        make || die

        cd ${S}/aim-transport-0.9.24c
        CPPFLAGS="$CPPFLAGS -I../jabberd -I../../jabberd" ./configure || die
        make || die

        cd ${S}/msn-transport-1.1
        make || die

        cd ${S}/yahoo-transport-0.8-1.4
        CPPFLAGS="$CPPFLAGS -I../jabberd -I../../jabberd" ./configure || die
        make || die

}


src_install() {

        cd ${S}
        /usr/sbin/userdel jabber
        /usr/sbin/groupdel jabber
        /usr/sbin/useradd jabber -d /usr/jabber -m
        /usr/sbin/groupadd jabber

        exeinto /etc/init.d ; newexe ${FILESDIR}/jabber.rc6 jabber
        exeinto /usr/sbin ; doexe ${FILESDIR}/jabber-server
        mkdir -p ${D}/usr/jabber-${PV}
        cp -rf * ${D}/usr/jabber-${PV}/

        chown -R jabber.jabber ${D}/usr/jabber-${PV}

}
