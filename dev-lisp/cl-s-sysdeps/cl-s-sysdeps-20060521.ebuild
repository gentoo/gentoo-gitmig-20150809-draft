# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-s-sysdeps/cl-s-sysdeps-20060521.ebuild,v 1.1 2006/05/21 06:36:52 mkennedy Exp $

inherit common-lisp

DESCRIPTION="A Common Lisp library implementing an abstraction layer over platform dependent functionality."
HOMEPAGE="http://homepage.mac.com/svc/s-sysdeps/"
SRC_URI="mirror://gentoo/${P#cl-}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="virtual/commonlisp
	dev-lisp/common-lisp-controller"

S=${WORKDIR}/${P#cl-}

CLPACKAGE=s-sysdeps

src_unpack() {
	unpack ${A}
	test -f ${S}/Makefile && rm ${S}/Makefile
}

src_install() {
	dodir /usr/share/common-lisp/source/${CLPACKAGE}
	dodir /usr/share/common-lisp/systems
	cp -R src test ${D}/usr/share/common-lisp/source/${CLPACKAGE}/
	common-lisp-install ${CLPACKAGE}.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/${CLPACKAGE}/${CLPACKAGE}.asd \
		/usr/share/common-lisp/systems/
	dohtml doc/*.html
	dodoc *.txt
}
