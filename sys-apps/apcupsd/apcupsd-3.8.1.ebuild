# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Holger Brueckner <darks@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apcupsd/apcupsd-3.8.1.ebuild,v 1.4 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="apc ups daemon with integrated tcp/ip remote shutdown"
SRC_URI="http://www.sibbald.com/apcupsd/download/oldversions/${A}"
HOMEPAGE="http://www.sibbald.com/apcupsd/"
 
DEPEND="virtual/glibc"
 
src_compile() {
    try ./configure   
    try make
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
   dodir /etc/rc.d/init.d
   exeinto /etc/rc.d/init.d
   doexe ${FILESDIR}/apcupsd 
   doexe ${FILESDIR}/halt  
}

pkg_postinst () {
   rc-update add apcupsd
}

pkg_prerm() {
   rc-update del apcupsd
}
