# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-imho/cl-imho-1.3.1.ebuild,v 1.5 2004/07/14 15:32:05 agriffis Exp $

inherit common-lisp

DESCRIPTION="IMHO is a toolkit that provides facilities for building highly interactive web applications, like WebCheckout. Some of the features that are in a useful state at this point are: session management, componentized document construction, template-based HTML rendering, and Java/Javascript integration. It is a loose functional equivalent of Apple's WebObjects framework."
HOMEPAGE="http://freesw.onshored.com/wwwdist/imho/
	http://alpha.onshored.com/lisp-software/"
SRC_URI="http://alpha.onshored.com/debian/local/${PN}_${PV}.orig.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-odcl
	=net-www/apache-1*"

CLPACKAGE=imho


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


pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
