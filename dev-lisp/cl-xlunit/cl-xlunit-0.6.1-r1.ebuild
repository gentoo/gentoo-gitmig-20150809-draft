# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xlunit/cl-xlunit-0.6.1-r1.ebuild,v 1.1 2004/02/12 09:13:21 mkennedy Exp $

inherit common-lisp

DESCRIPTION="XLUnit is a Test Framework based on XPTest and JUnit."
HOMEPAGE="http://www.cliki.net/xlunit"
SRC_URI="mirror://gentoo/xlunit-${PV}.tar.gz"
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
