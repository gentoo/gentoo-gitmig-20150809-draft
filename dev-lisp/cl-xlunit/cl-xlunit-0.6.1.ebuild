# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xlunit/cl-xlunit-0.6.1.ebuild,v 1.2 2003/10/17 20:22:22 mkennedy Exp $

inherit common-lisp

DESCRIPTION="XLUnit is a Test Framework based on XPTest and JUnit. XLUnit strives to have a good balance between low programmer overhead and good support for fixture setup and teardown. XLUnit has greatly decreased programmer overhead compared to XPTest while adding more functionality from JUnit."
HOMEPAGE="http://www.cliki.net/xlunit"
SRC_URI="mirror://gentoo/xlunit-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=xlunit

S=${WORKDIR}/xlunit-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README LICENSE
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
