# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-imho/cl-imho-1.3.1-r1.ebuild,v 1.1 2004/02/12 09:13:13 mkennedy Exp $

inherit common-lisp

DESCRIPTION="IMHO is a toolkit that provides facilities for building highly interactive web applications"
HOMEPAGE="http://freesw.onshored.com/wwwdist/imho/
	http://alpha.onshored.com/lisp-software/"
SRC_URI="http://alpha.onshored.com/debian/local/${PN}_${PV}.orig.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-odcl
	=net-www/apache-1*"

CLPACKAGE=imho

S=${WORKDIR}/${P}

src_compile() {
	cd apache && make CFLAGS="${CFLAGS} -Wall -Wstrict-prototypes -fPIC" || die
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe apache/apache-1.3/mod_webapp.so

	insinto /usr/include/webapplib
	doins apache/webapplib/*.h
	dolib.so apache/webapplib/libwebapp.so

	dodoc apache/doc/*.txt
	dodoc doc/*.txt doc/*.pdf
	dohtml doc/*.html

	insinto /usr/share/common-lisp/source/imho
	doins *.lisp imho.asd imho.system
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/imho/imho.asd \
		/usr/share/common-lisp/systems/imho.asd
	dosym /usr/share/common-lisp/source/imho/imho.system \
		/usr/share/common-lisp/systems/imho.system
}
