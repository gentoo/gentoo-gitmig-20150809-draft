# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winesetuptk/winesetuptk-0.6.0b-r2.ebuild,v 1.5 2002/08/19 17:47:45 cybersystem Exp $

MY_P1=tcltk-${P}
P=${P}
S=${WORKDIR}/${P}
DESCRIPTION="Setup tool for WiNE adapted from Codeweavers by Debian"
SRC_URI="http://ftp.debian.org/debian/pool/main/w/winesetuptk/${P/-/_}-1.tar.gz"
HOMEPAGE="http://packages.debian.org/unstable/otherosfs/winesetuptk.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 -ppc"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {

	unpack ${P/-/_}-1.tar.gz
	cd ${S}

	tar zxf ${MY_P1}.tar.gz
	tar zxf ${P}.tar.gz

}

src_compile() {
	
	cd ${S}/${MY_P1}
	./build.sh
	
	cd ${S}/${P}

	local myconf
	myconf="${myconf} --with-tcltk=${S}/${MY_P1}"
	myconf="${myconf} --with-launcher=/usr/bin --with-exe=/usr/bin"
	myconf="${myconf} --with-doc=/usr/share/doc/${P}"

	econf \
		--sysconfdir=/etc/wine \
		--enable-curses \
		${myconf} || die

	make || die

}

src_install () {

	cd ${S}/${P}
	make \
		PREFIX_LAUNCHER=${D}/usr/bin \
		PREFIX_EXE=${D}/usr/bin \
		PREFIX_DOC=${D}/usr/share/doc/${P} \
		install || die
	
	dodoc doc/*
}
