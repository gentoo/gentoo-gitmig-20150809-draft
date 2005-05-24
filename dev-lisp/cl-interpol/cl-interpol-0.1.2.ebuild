# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-interpol/cl-interpol-0.1.2.ebuild,v 1.4 2005/05/24 18:48:33 mkennedy Exp $

inherit common-lisp

DESCRIPTION="String interpolation for Common Lisp similar to Perl or Unix shell scripts."
HOMEPAGE="http://weitz.de/cl-interpol/
	http://www.cliki.net/cl-interpol"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-interpol

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc CHANGELOG README
	dohtml doc/index.html
}
