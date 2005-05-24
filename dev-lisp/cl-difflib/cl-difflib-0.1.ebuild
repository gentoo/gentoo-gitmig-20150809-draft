# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-difflib/cl-difflib-0.1.ebuild,v 1.4 2005/05/24 18:48:33 mkennedy Exp $

inherit common-lisp

DESCRIPTION="CL-DIFFLIB is a Lisp library for computing differences between sequences."
HOMEPAGE="http://www.cliki.net/CL-DIFFLIB"
SRC_URI="http://lemonodor.com/code/${PN}_${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-difflib

S=${WORKDIR}/${PN}_${PV}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc LICENSE.txt
}
