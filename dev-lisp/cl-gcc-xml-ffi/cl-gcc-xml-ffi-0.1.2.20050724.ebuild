# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-gcc-xml-ffi/cl-gcc-xml-ffi-0.1.2.20050724.ebuild,v 1.1 2005/07/25 20:36:55 mkennedy Exp $

inherit common-lisp

MY_PN=${PN/cl-/}

DESCRIPTION="Cyrus Harmon's Common Lisp GCC-XML FFI library."
HOMEPAGE="http://www.cyrusharmon.org/cl/blog/"
SRC_URI="http://cyrusharmon.org/cl/static/releases/${MY_PN}-${PV/.2005/-2005}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="dev-lisp/cl-ch-util
	dev-lisp/cl-uffi
	dev-lisp/cl-xmls
	dev-cpp/gccxml"

S=${WORKDIR}/${MY_PN}

CLPACKAGE='gcc-xml-ffi gcc-xml-ffi-test'

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-fasl-output-gentoo.patch || die
	rm ${S}/Makefile
}

src_install() {
	dodir $CLSYSTEMROOT
	insinto $CLSOURCEROOT/gcc-xml-ffi
	doins *.asd
	insinto $CLSOURCEROOT/gcc-xml-ffi/src/
	doins src/*.cl
	insinto $CLSOURCEROOT/gcc-xml-ffi/test/
	doins test/*.cl
	dosym ${CLSOURCEROOT}/gcc-xml-ffi/gcc-xml-ffi.asd ${CLSYSTEMROOT}/gcc-xml-ffi.asd
	dosym ${CLSOURCEROOT}/gcc-xml-ffi/gcc-xml-ffi-test.asd ${CLSYSTEMROOT}/gcc-xml-ffi-test.asd
	dodoc ChangeLog README
}
