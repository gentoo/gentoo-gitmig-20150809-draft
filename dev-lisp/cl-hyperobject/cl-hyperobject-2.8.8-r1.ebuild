# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-hyperobject/cl-hyperobject-2.8.8-r1.ebuild,v 1.1 2004/02/12 09:13:13 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Hyperobject is a Common Lisp library for representing objects."
HOMEPAGE="http://hyperobject.b9.com/
	http://www.cliki.net/hyperobject"
SRC_URI="http://files.b9.com/hyperobject/hyperobject-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND="dev-lisp/common-lisp-controller
	dev-lisp/cl-kmrcl
	dev-lisp/cl-rt
	dev-lisp/cl-sql
	virtual/commonlisp"

CLPACKAGE=hyperobject

S=${WORKDIR}/hyperobject-${PV}

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
	dodoc COPYING README
	dohtml docs/*.html
}
