# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xerces-c/xerces-c-2.4.0.ebuild,v 1.3 2004/02/17 00:07:59 zhen Exp $

MY_PV=${PV//./_}

DESCRIPTION="Xerces-C++ is a validating XML parser written in a portable subset of C++."

SRC_URI="http://xml.apache.org/dist/xerces-c/stable/${PN}-src${MY_PV}.tar.gz"
HOMEPAGE="http://xml.apache.org/xerces-c/index.html"

DEPEND="virtual/glibc"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="doc"

S=${WORKDIR}/${PN}-src${MY_PV}

src_compile() {
	export MAKEOPTS="-j1"
	export XERCESCROOT=${S}
	cd src/xercesc
	econf || die
	emake || die
	unset MAKEOPTS
}

src_install () {
	export XERCESCROOT=${S}
	cd ${S}/src/xercesc
	make DESTDIR=${D} install || die

	if [ "`use doc`" ]; then
		dodir /usr/share/doc/${P}
		cp -a ${S}/samples ${D}/usr/share/doc/${P}
		dohtml -r doc/html
	fi

	cd ${S}
	dodoc STATUS LICENSE LICENSE.txt credits.txt version.incl xerces-c.spec
	dohtml Readme.html

	unset XERCESCROOT
}
