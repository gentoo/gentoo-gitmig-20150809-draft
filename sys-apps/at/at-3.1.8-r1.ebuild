# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/at/at-3.1.8-r1.ebuild,v 1.2 2000/08/16 04:38:22 drobbins Exp $

P=at-3.1.8
A="${P}.tar.bz2 ${P}.dif"
S=${WORKDIR}/${P}
DESCRIPTION="queues jobs for later execution"
SRC_URI="ftp://ftp.kreonet.re.kr/.2/Linux/Jurix/source/chroot/appl/at/${P}.tar.bz2
	 ftp://ftp.kreonet.re.kr/.2/Linux/Jurix/source/chroot/appl/at/${P}.dif"

src_compile() {

    ./configure --host=${CHOST} --sysconfdir=/etc/at 
    make

}

src_unpack() {

    unpack ${P}.tar.bz2
    cd ${S}
    patch -p0 < ${DISTDIR}/${P}.dif

}

src_install() {                 

	cd ${S}
	into /usr
	chmod 755 batch
	chmod 755 atrun
	dobin at batch
	dosym /usr/bin/at /usr/bin/atrm
	dosym /usr/bin/at /usr/bin/atq
	dosbin atd atrun
	for i in atjobs atspool
	do
	  dodir /var/spool/${i}
 	  fperms 700 /var/spool/${i}
	  fowners daemon.daemon /var/spool/${i}
	done
	doman at.1 at_allow.5 atd.8 atrun.8
	dodoc COPYING ChangeLog Copyright Problems README
	dodir /etc/rc.d/init.d
	cp ${O}/files/atd ${D}/etc/rc.d/init.d/  
	dodir /etc/at
 	cp ${O}/files/at.deny ${D}/etc/at/

}



