# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/jabber-server/jabber-server-1.4.1.ebuild,v 1.1 2001/12/16 01:20:50 verwilst Exp $

S="${WORKDIR}/jabber-1.4.1"
HOMEPAGE="http://www.jabber.org"
DESCRIPTION="Jabber Server 1.4.1"

SRC_URI="http://download.jabber.org/dists/1.4/final/jabber-1.4.1.tar.gz
		 http://download.jabber.org/dists/transports/aim-transport/aim-transport-0.9.24c.tar.gz
		 http://download.jabber.org/dists/1.4/final/conference-0.4.1.tar.gz
		 http://download.jabber.org/dists/transports/irc-transport/irc-transport-0.1.1-1.4.linux.tar.gz
		 http://download.jabber.org/dists/1.4/final/jud-0.4.tar.gz
		 http://download.jabber.org/dists/1.4/final/msn-transport-1.1.tar.gz
		 http://download.jabber.org/dists/1.4/final/yahoo-transport-0.8-1.4.linux.tar.gz"

DEPEND="virtual/glibc
		virtual/python
		>=dev-libs/pth-1.4.0
		>=app-admin/sudo-1.6.3_p7"

src_compile() {

	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
	./configure || die
	make || die
	mkdir -p ${D}/usr/jabber
	cp -rf ${S} ${D}/usr/jabber

	cp -rf ${WORKDIR}/conference-0.4.1 ${S}
	cd ${S}/conference-0.4.1
	make || die

	cp -rf ${WORKDIR}/jud-0.4 ${S}
	cd ${S}/jud-0.4
	make || die

	cp -rf ${WORKDIR}/aim-transport-0.9.24c ${S}
	cd ${S}/aim-transport-0.9.24c
	CPPFLAGS="$CPPFLAGS -I../jabberd -I../../jabberd" ./configure || die
	make || die

	cp -rf ${WORKDIR}/msn-transport-1.1 ${S}
	cd ${S}/msn-transport-1.1
	make || die

	cp -rf ${WORKDIR}/yahoo-transport-0.8-1.4 ${S}
	cd ${S}/yahoo-transport-0.8-1.4
	CPPFLAGS="$CPPFLAGS -I../jabberd -I../../jabberd" ./configure || die
	make || die

	cd ${S}
	echo " " > error.log
	echo " " > record.log

	mv jabber.xml jabber.xml.bak
	mkdir -p ${D}/etc/init.d/
	cp ${FILESDIR}/ServSetup ${S}
	cp ${FILESDIR}/SetupEngine.py ${S}
	chmod a+x ${S}/ServSetup

}

src_install() {

	cd ${S}
	/usr/sbin/userdel jabber
	/usr/sbin/groupdel jabber
	/usr/sbin/useradd jabber -d /usr/jabber -m
	/usr/sbin/groupadd jabber

	exeinto /etc/init.d ; newexe ${FILESDIR}/jabber.rc6 jabber
	exeinto /usr/sbin ; doexe ${FILESDIR}/jabber-server
	mkdir -p ${D}/usr/jabber
	cp -rf * ${D}/usr/jabber/

	chown -R jabber.jabber ${D}/usr/jabber
}

pkg_postinst() {

	echo
	echo "#########################################################################"
	echo "# Done!																  #"
	echo "# Now go to /usr/jabber, and run './ServSetup to configure your server. #"
	echo "# Have fun!															  #"
	echo "#########################################################################"
	echo

}


