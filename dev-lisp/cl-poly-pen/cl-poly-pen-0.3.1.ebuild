# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-poly-pen/cl-poly-pen-0.3.1.ebuild,v 1.1 2005/03/20 21:23:24 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Poly-pen is a graphical proxy for Common Lisp. It links hi-level operations to low-level back-ends libraries."
HOMEPAGE="http://ygingras.net/poly-pen"
SRC_URI="http://ygingras.net/files/poly-pen-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/cl-ppcre
	dev-lisp/cl-sdl
	dev-lisp/cl-gd
	dev-lisp/cl-osicat"

CLPACKAGE=poly-pen

S=${WORKDIR}/poly-pen-${PV}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dohtml index.html *.jpg
	dodoc doc.{pdf,ps} README* ChangeLog
}
