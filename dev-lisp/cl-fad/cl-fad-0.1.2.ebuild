# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-fad/cl-fad-0.1.2.ebuild,v 1.1 2005/03/19 21:25:40 mkennedy Exp $

inherit common-lisp

DESCRIPTION='CL-FAD is a thin portability layer atop the Common Lisp standard pathname functions.'
HOMEPAGE="http://weitz.de/cl-fad/"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-fad

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc CHANGELOG README
	dohtml doc/index.html
}
