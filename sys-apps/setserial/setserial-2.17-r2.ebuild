# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/setserial/setserial-2.17-r2.ebuild,v 1.3 2002/07/11 06:30:55 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Configure your serial ports with it"
SRC_URI="ftp://tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz
	 ftp://ftp.sunsite.org.uk/Mirrors/tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz"

DEPEND="virtual/glibc"

src_compile() {						   

	econf || die
	pmake setserial || die

}

src_install() {	  
						 
	doman setserial.8
	into /
	dobin setserial

	dodoc README 
	docinto txt
	dodoc Documentation/*
	insinto /etc
	doins serial.conf
}
