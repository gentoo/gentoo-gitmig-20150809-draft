# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-gd/cl-gd-0.1.4.ebuild,v 1.5 2004/06/30 17:16:54 vapier Exp $

inherit common-lisp

DESCRIPTION="CL-GD is a library for Common Lisp which provides an interface to the GD Graphics Library for the dynamic creation of images. It is based on UFFI and should thus be portable to all CL implementations supported by UFFI."
HOMEPAGE="http://weitz.de/cl-gd http://www.cliki.net/cl-gd"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lisp/common-lisp-controller
	>=dev-lisp/cl-uffi-1.3.4
	media-libs/libpng
	media-libs/jpeg
	media-libs/freetype
	>=media-libs/gd-2.0.15
	sys-libs/zlib
	virtual/commonlisp"

CLPACKAGE=cl-gd

src_compile() {
	gcc ${CFLAGS} -fPIC -c cl-gd-glue.c
	ld -lgd -lz -lpng -ljpeg -lfreetype -lm -shared cl-gd-glue.o -o cl-gd-glue.so
	rm cl-gd-glue.o
}

src_install() {
	insinto /usr/lib
	doins cl-gd-glue.so
	common-lisp-install *.asd *.lisp
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/cl-gd/cl-gd.asd \
		/usr/share/common-lisp/systems/cl-gd.asd
# 	dosym /usr/share/common-lisp/source/cl-gd/cl-gd-test.asd \
# 		 /usr/share/common-lisp/systems/cl-gd.asd
# 	insinto /usr/share/common-lisp/source/cl-gd/test
# 	doins test/*
	dodoc CHANGELOG README
	dohtml doc/*.html
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
