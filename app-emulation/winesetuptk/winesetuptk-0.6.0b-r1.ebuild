# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Seemant Kulleen <seemant@rocketmail.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winesetuptk/winesetuptk-0.6.0b-r1.ebuild,v 1.1 2002/04/27 01:28:47 seemant Exp $

MY_P=${PN}_${PV}-1.tar.gz
PRE=tcltk-winesetuptk-0.6.0b
SEC=winesetuptk-0.6.0b
S=${WORKDIR}/${P}
DESCRIPTION="Setup tool for WiNE adapted from Codeweavers by Debian"
SRC_URI="http://ftp.debian.org/debian/pool/main/w/winesetuptk/${MY_P}"
HOMEPAGE="http://packages.debian.org/unstable/otherosfs/winesetuptk.html"

DEPEND="virtual/glibc
		virtual/x11"

RDEPEND="app-emulation/wine"

src_unpack() {

	unpack ${MY_P}
	cd ${S}

	tar zxf ${PRE}.tar.gz
	tar zxf ${SEC}.tar.gz

}

src_compile() {
    
    cd ${S}/${PRE}
	./build.sh
	

	cd ${S}/${SEC}

    local myconf
	
	myconf="${myconf} --with-tcltk=${S}/${PRE}"
	myconf="${myconf} --with-launcher=/usr/bin --with-exe=/usr/bin"
	myconf="${myconf} --with-doc=/usr/share/doc/${P}"

    ./configure 	\
		--prefix=/usr	\
		--sysconfdir=/etc/wine	\
		--host=${CHOST}	\
		--enable-curses	\
		${myconf} || die

	emake || die

}

src_install () {

	cd ${S}/${SEC}
    make 	\
		PREFIX_LAUNCHER=${D}/usr/bin 	\
		PREFIX_EXE=${D}/usr/bin 		\
		PREFIX_DOC=${D}/usr/share/doc/${P} \
		install || die
    
}
