# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-interpol/cl-interpol-0.1.0.ebuild,v 1.2 2003/10/26 17:26:16 mkennedy Exp $

inherit common-lisp

DESCRIPTION="CL-INTERPOL is a library for Common Lisp which modifies the reader so that you can have interpolation within strings similar to Perl or Unix Shell scripts."
HOMEPAGE="http://weitz.de/cl-interpol/
	http://www.cliki.net/cl-interpol"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-interpol

S=${WORKDIR}/${P}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc CHANGELOG README
	dohtml doc/index.html
}


pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
