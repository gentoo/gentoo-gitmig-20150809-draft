# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/xsat/xsat-0.21.ebuild,v 1.3 2002/07/11 06:30:49 drobbins Exp $

MY_P=${PN}${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GUI for AudioGalaxy Satellite."
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/xsatellite/${P}.tar.gz"

HOMEPAGE="http://xsatellite.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-lang/tk"

src_install () {

	INSTALLDIR=/usr/share/xsat
	dodir ${INSTALLDIR}/{gif,Satellite}
	dodir ${INSTALLDIR}/xsat/{wav,config,tcl}

	insinto ${INSTALLDIR}/gif
	doins gif/*

	insinto ${INSTALLDIR}/Satellite
	doins Satellite/*

	insinto ${INSTALLDIR}/wav
	doins wav/*

	insinto ${INSTALLDIR}/config
	doins config/*

	insinto ${INSTALLDIR}/tcl
	doins tcl/*
	
	exeinto ${INSTALLDIR}
	doexe xsatellite.tcl
	
	dodoc COPYING README CHANGES
	
	exeinto /usr/bin
	doexe ${FILESDIR}/xsatellite
	echo -e "cd ${INSTALLDIR}">>${D}/usr/bin/xsatellite
	echo -e "wish xsatellite.tcl">>${D}/usr/bin/xsatellite
}

pkg_postinst() {
	einfo	"_________________________________________________________"
	einfo	"|                                                       |"
	einfo	"| You must create two files in your home:               |"
	einfo	"|  account.txt (email and password of your login in     |"
	einfo	"|  www.audiogalaxy.com).                                |"
	einfo	"|  shares.txt (the dirs when you store the mp3, and in  |"
	einfo	"|  the first line the dir for download).                |"
	einfo	"| You must make a account in www.audiogalaxy.com for    |"
	einfo	"| use this client.                                      |"
	einfo 	"| ***************************************************** |"
	einfo	"| Xsatellite uses the offcial client from AG that is    |"
	einfo	"| not free.                                             |"
	einfo 	"| ***************************************************** |"
	einfo	"|_______________________________________________________|"
}

