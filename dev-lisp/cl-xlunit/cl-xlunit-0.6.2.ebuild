# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xlunit/cl-xlunit-0.6.2.ebuild,v 1.2 2004/06/24 23:56:56 agriffis Exp $

inherit common-lisp

DESCRIPTION="XLUnit is a Test Framework based on XPTest and JUnit."
HOMEPAGE="http://www.cliki.net/xlunit"
SRC_URI="http://files.b9.com/xlunit/xlunit-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=xlunit

S=${WORKDIR}/xlunit-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc README LICENSE
}
