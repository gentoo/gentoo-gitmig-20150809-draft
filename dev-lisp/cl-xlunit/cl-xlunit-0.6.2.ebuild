# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xlunit/cl-xlunit-0.6.2.ebuild,v 1.5 2005/05/24 18:48:36 mkennedy Exp $

inherit common-lisp

DESCRIPTION="XLUnit is a Test Framework based on XPTest and JUnit."
HOMEPAGE="http://www.cliki.net/xlunit"
SRC_URI="http://files.b9.com/xlunit/xlunit-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
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
