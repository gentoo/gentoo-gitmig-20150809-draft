# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/httrack/httrack-3.23.ebuild,v 1.1 2005/03/18 14:46:09 seemant Exp $

DESCRIPTION="HTTrack Website Copier, Open Source Offline Browser"
HOMEPAGE="http://www.httrack.com/"
SRC_URI="http://www.httrack.com/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"
S="${WORKDIR}/${P}.20"

src_compile() {
	#First create libhttrack.so
	econf --host=${CHOST} || die "1st econf failed"
	cd src
	emake libhttrack.la || die "failed making libhttrack.so"
	cp .libs/libhttrack.so.1.0.0 ${WORKDIR}
	cd ${WORKDIR}
	rm -rf ${P}.20
	unpack ${A}
	cp libhttrack.so.1.0.0 ${P}/src/libhttrack.so.1.0.0
	cd ${P}/src
	ln -s libhttrack.so.1.0.0 libhttrack.so
	cd ${S}

	#Doing the complete compilation

	econf --host=${CHOST} || die "2nd econf failed"
	make || die "make failed"
}

src_install() {

	einstall || die "Failed on einstall"
	cd ${D}/usr/share/doc/
	mv httrack ${P}
	cd ${S}
	dodoc AUTHORS COPYING INSTALL NEWS README ChangeLog
	dodoc greetings.txt history.txt
	dohtml httrack-doc.html
}
