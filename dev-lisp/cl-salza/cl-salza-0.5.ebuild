# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-salza/cl-salza-0.5.ebuild,v 1.2 2005/03/22 15:33:35 mkennedy Exp $

inherit common-lisp

DESCRIPTION='Salza is a Common Lisp Library that provides an FFI-less interface to the ZLIB and DEFLATE compressed data formats.'
HOMEPAGE="http://www.cliki.net/Salza"
SRC_URI="http://www.xach.com/lisp/salza/salza-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp"

CLPACKAGE=salza

S=${WORKDIR}/salza-${PV}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc README ChangeLog LICENSE
	docinto examples
	dodoc examples/*
}
