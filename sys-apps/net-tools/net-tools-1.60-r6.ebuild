# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.60-r6.ebuild,v 1.2 2003/06/21 21:19:40 drobbins Exp $

inherit eutils

DESCRIPTION="standard Linux network tools"
SRC_URI="http://www.tazenda.demon.co.uk/phil/net-tools/${P}.tar.bz2
	mirror://gentoo/${P}-gentoo-extra.tar.bz2"
HOMEPAGE="http://sites.inka.de/lina/linux/NetTools/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha hppa arm mips"
IUSE="nls build"

DEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	PATCHDIR=${WORKDIR}/${P}-gentoo

	unpack ${A}
	cd ${S}

	# some redhat patches
	epatch ${PATCHDIR}/net-tools-1.57-bug22040.patch
	epatch ${PATCHDIR}/net-tools-1.60-manydevs.patch
	epatch ${PATCHDIR}/net-tools-1.60-miiioctl.patch
	
	cp ${PATCHDIR}/net-tools-1.60-config.h config.h
	cp ${PATCHDIR}/net-tools-1.60-config.make config.make

	cp Makefile Makefile.orig
	sed -e "s:-O2 -Wall -g:${CFLAGS}:" Makefile.orig > Makefile

	cd man
	cp Makefile Makefile.orig
	sed -e "s:/usr/man:/usr/share/man:" Makefile.orig > Makefile

	cp -f ${PATCHDIR}/ether-wake.c ${S}
	cd ${S}

	if [ -z "`use nls`" ] ; then
		mv config.h config.h.orig
		sed 's:\(#define I18N\) 1:\1 0:' config.h.orig > config.h

		mv config.make config.make.orig
		sed 's:I18N=1:I18N=0:' config.make.orig > config.make
	fi

	touch config.{h,make}		# sync timestamps
}

src_compile() {
	# Changing "emake" to "make" closes half of bug #820; 
	# configure is run from *inside* the Makefile, sometimes 
	# breaking parallel makes (if ./configure doesn't finish first) 
	make || die	

	if [ "`use nls`" ] ; then
		cd po
		make || die
		cd ${S}
	fi

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
	
	if [ -z "`use build`" ]
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
