# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-gcc-xml-ffi/cl-gcc-xml-ffi-0.1.3.20051115.ebuild,v 1.3 2009/12/23 17:13:49 scarabeus Exp $

inherit common-lisp eutils

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

CLPACKAGE="gcc-xml-ffi gcc-xml-ffi-test"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PV}-fasl-output-gentoo.patch"
	rm "${S}"/Makefile
}

src_install() {
	insinto "${CLSOURCEROOT}"/gcc-xml-ffi
	doins *.asd || die
	insinto "${CLSOURCEROOT}"/gcc-xml-ffi/src/
	doins src/*.cl || die
	insinto "${CLSOURCEROOT}"/gcc-xml-ffi/test/
	doins test/*.cl || die
	dosym "${CLSOURCEROOT}"/gcc-xml-ffi/gcc-xml-ffi.asd "${CLSYSTEMROOT}"/gcc-xml-ffi.asd
	dosym "${CLSOURCEROOT}"/gcc-xml-ffi/gcc-xml-ffi-test.asd "${CLSYSTEMROOT}"/gcc-xml-ffi-test.asd
	dodoc ChangeLog README || die
}
