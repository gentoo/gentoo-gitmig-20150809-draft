# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/setserial/setserial-2.17-r2.ebuild,v 1.6 2002/08/14 03:29:42 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Configure your serial ports with it"
SRC_URI="ftp://tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz
	 ftp://ftp.sunsite.org.uk/Mirrors/tsx-11.mit.edu/pub/linux/sources/sbin/${P}.tar.gz"
HOMEPAGE=""
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

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
