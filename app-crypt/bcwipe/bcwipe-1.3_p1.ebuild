# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcwipe/bcwipe-1.3_p1.ebuild,v 1.1 2003/09/20 22:32:38 prez Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="BCWipe secure file removal utility"
SRC_URI="http://www.jetico.com/linux/BCWipe-${PV/_p/-}.tar.gz
		 http://www.jetico.com/linux/BCWipe.doc.tgz"
HOMEPAGE="http://www.jetico.com"
SLOT="0"
LICENSE="bestcrypt"
DEPEND="virtual/glibc"
RDEPEND=""
KEYWORDS="x86"

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "Make failed"
}

src_install () {
	doman bcwipe.1
	exeinto /bin ; doexe bcwipe
	cd ../bcwipe-help
	dodir /usr/share/doc/${P}
	cp -r * ${D}/usr/share/doc/${P}
}
