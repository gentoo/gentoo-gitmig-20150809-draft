# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-getopt/cl-getopt-1.1.0.ebuild,v 1.5 2005/03/21 07:21:03 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp command-line processor similar to GNU getopt_long."
HOMEPAGE="http://www.b9.com"
SRC_URI="ftp://ftp.b9.com/getopt/getopt-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-ptester
	virtual/commonlisp"

CLPACKAGE=getopt

S=${WORKDIR}/getopt-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc LICENSE README
}
