# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org> 
# Author: Holger Brueckner <darks@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apcupsd/apcupsd-3.8.1.ebuild,v 1.5 2001/10/06 16:44:02 drobbins Exp $

# WARNING: THIS EBUILD HAS ONLY BEEN PARTIALLY CONVERTED TO THE NEW RC6 INITSCRIPTS

S=${WORKDIR}/${P}
DESCRIPTION="APC UPS daemon with integrated tcp/ip remote shutdown"
SRC_URI="http://www.sibbald.com/apcupsd/download/oldversions/${P}.tar.gz"
HOMEPAGE="http://www.sibbald.com/apcupsd/"
 
DEPEND="virtual/glibc"
 
src_compile() {
	./configure || die   
	make || die
}
 
src_install () {
	dosbin apcupsd apcaccess apcnetd 
	cd ${S}/etc
	dodir etc/apcupsd
	insinto etc/apcupsd
	doins *.conf
	exeinto etc/apcupsd
	doexe changeme commfailure commok mainsback onbattery
	doexe ${FILESDIR}/apccontrol
	dodir var/log/apcupsd
	sed -e "s:/etc/apcupsd:/var/log/apcupsd:g" ${D}/etc/apcupsd/apcupsd.conf > ${D}/etc/apcupsd/apcupsd.conf.tmp
	mv ${D}/etc/apcupsd/apcupsd.conf.tmp ${D}/etc/apcupsd/apcupsd.conf   
	cd ${S}/doc
	dodoc *
	docinto developers
	dodoc developers/*
	docinto manual
	dodoc manual/*
	mv ${S}/doc/apcupsd.man ${S}/doc/apcupsd.8
	doman apcupsd.8
	dodir /etc/init.d
	exeinto /etc/init.d
	doexe ${FILESDIR}/apcupsd 
	doexe ${FILESDIR}/halt  
}
