# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-puri/cl-puri-1.3.1.1.ebuild,v 1.6 2005/03/18 07:27:19 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Portable URI library for Common Lisp based on the Franz, Inc. :net.uri module."
HOMEPAGE="http://www.b9.com"
SRC_URI="ftp://ftp.b9.com/puri/puri-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-ptester
	virtual/commonlisp"

CLPACKAGE=puri

S=${WORKDIR}/puri-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dohtml uri.html
	dodoc README LICENSE
}
