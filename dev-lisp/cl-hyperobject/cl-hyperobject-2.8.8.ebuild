# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-hyperobject/cl-hyperobject-2.8.8.ebuild,v 1.1 2004/01/27 22:04:38 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Hyperobject is a Common Lisp library for representing objects."
HOMEPAGE="http://hyperobject.b9.com/
	http://www.cliki.net/hyperobject"
SRC_URI="http://files.b9.com/hyperobject/hyperobject-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
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

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
