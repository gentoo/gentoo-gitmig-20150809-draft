# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

MY_PV="`echo ${PV} |sed -e 's/\./\.ogle/3'`"
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="A portable abstraction library for DVD decryption"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/libdvdcss-${MY_PV}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

DEPEND="virtual/glibc"


src_compile() {

	./configure --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info ||die
		    
	make || die
}

src_install() {
	
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}

