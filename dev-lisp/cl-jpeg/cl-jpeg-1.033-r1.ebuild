# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-jpeg/cl-jpeg-1.033-r1.ebuild,v 1.1 2004/02/12 09:13:14 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A JPEG library for Common Lisp"
HOMEPAGE="http://sourceforge.net/projects/cljl"
SRC_URI="mirror://sourceforge/cljl/cljl-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=cl-jpeg

S=${WORKDIR}/cljl

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc LICENSE
}
