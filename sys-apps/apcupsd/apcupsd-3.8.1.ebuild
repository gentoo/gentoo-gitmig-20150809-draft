# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apcupsd/apcupsd-3.8.1.ebuild,v 1.9 2002/07/14 19:20:16 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="APC UPS daemon with integrated tcp/ip remote shutdown"
SRC_URI="http://www.sibbald.com/apcupsd/download/oldversions/${P}.tar.gz"
HOMEPAGE="http://www.sibbald.com/apcupsd/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
 
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
