# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/httrack/httrack-3.30.ebuild,v 1.1 2005/03/18 14:46:09 seemant Exp $

DESCRIPTION="HTTrack Website Copier, Open Source Offline Browser"
HOMEPAGE="http://www.httrack.com/"
SRC_URI="http://www.httrack.com/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"
MY_P=${P}.01
S="${WORKDIR}/${MY_P}"

src_compile() {
	#First create libhttrack.so
	econf --host=${CHOST} || die "1st econf failed"
	cd src
	emake libhttrack.la || die "failed making libhttrack.so"
	cp .libs/libhttrack.so.1.0.330 ${WORKDIR}
	cd ${WORKDIR}
	rm -rf ${MY_P}
	unpack ${A}
	cp libhttrack.so.1.0.330 ${MY_P}/src/libhttrack.so.1.0.330
	cd ${MY_P}/src
	ln -s libhttrack.so.1.0.330 libhttrack.so
	cd ${S}

	#Doing the complete compilation

	econf --host=${CHOST} || die "2nd econf failed"
	make || die "make failed"
}

src_install() {
	einstall || die "Failed on einstall"
	cd ${D}/usr/share/doc/
	mv httrack ${MY_P}
	cd ${S}
	dodoc AUTHORS COPYING INSTALL README
	dodoc greetings.txt history.txt
	dohtml httrack-doc.html
}
