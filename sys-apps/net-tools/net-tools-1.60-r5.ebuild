# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.60-r5.ebuild,v 1.1 2002/07/16 17:17:05 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="standard Linux network tools"
SRC_URI="http://www.tazenda.demon.co.uk/phil/net-tools/${P}.tar.bz2"
HOMEPAGE="http://sites.inka.de/lina/linux/NetTools/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
		nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	# some redhat patches
	cat ${FILESDIR}/net-tools-1.57-bug22040.patch | patch -d ${S} -p1
	cat ${FILESDIR}/net-tools-1.60-manydevs.patch | patch -d ${S} -p0
	cat ${FILESDIR}/net-tools-1.60-miiioctl.patch | patch -d ${S} -p1
	cd ${S}
	cp ${FILESDIR}/net-tools-1.60-config.h config.h
	cp ${FILESDIR}/net-tools-1.60-config.make config.make
	cp Makefile Makefile.orig
	sed -e "s/-O2 -Wall -g/${CFLAGS}/" Makefile.orig > Makefile
	cd man
	cp Makefile Makefile.orig
	sed -e "s:/usr/man:/usr/share/man:" Makefile.orig > Makefile
	cp ${FILESDIR}/ether-wake.c ${S}

	if [ -z "`use nls`" ]
	then
		cd ${S}
		mv config.h config.h.orig
		sed 's:\(#define I18N\) 1:\1 0:' config.h.orig > config.h

		mv config.make config.make.orig
		sed 's:I18N=1:I18N=0:' config.make.orig > config.make
	fi
	
}

src_compile() {
	# Changing "emake" to "make" closes half of bug #820; configure is run from *inside*
	# the Makefile, sometimes breaking parallel makes (if ./configure doesn't finish first) 
	
	make || die	

	if [ "`use nls`" ]
	then
		cd po
		make || die
	fi
	cd ${S}
	gcc ${CFLAGS} -o ether-wake ether-wake.c || die
}

src_install() {
	make BASEDIR=${D} install || die
	dosbin ether-wake
	mv ${D}/bin/* ${D}/sbin
	for i in hostname domainname netstat dnsdomainname ypdomainname nisdomainname
	do
		mv ${D}/sbin/${i} ${D}/bin
	done
	dodir /usr/bin
	dosym /bin/hostname /usr/bin/hostname
	if [ -z "`use bootcd`" ] && [ -z "`use build`" ]
	then
		dodoc COPYING README README.ipv6 TODO
	else
		#only install /bin/hostname
		rm -rf ${D}/usr
		rm -rf ${D}/sbin
		rm -f ${D}/bin/{domainname,netstat,dnsdomainname}
		rm -f ${D}/bin/{ypdomainname,nisdomainname}
	fi
}

