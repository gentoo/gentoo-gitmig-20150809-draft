# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-puri/cl-puri-1.3.1-r1.ebuild,v 1.1 2004/02/12 09:13:15 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Portable URI library for Common Lisp based on the Franz, Inc. :net.uri module."
HOMEPAGE="http://www.b9.com"
SRC_URI="ftp://ftp.b9.com/puri/puri-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
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
