# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-gd/cl-gd-0.2.0.ebuild,v 1.4 2004/06/30 17:16:54 vapier Exp $

inherit common-lisp

DESCRIPTION="CL-GD is a library for Common Lisp which provides an interface to the GD Graphics Library for the dynamic creation of images. It is based on UFFI and should thus be portable to all CL implementations supported by UFFI."
HOMEPAGE="http://weitz.de/cl-gd http://www.cliki.net/cl-gd"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"

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

	insinto /usr/share/common-lisp/source/cl-gd
	doins `ls *.asd *.lisp |grep -v ^cl-gd-test`
	dodir /usr/share/common-lisp/systems
	dosym /usr/share/common-lisp/source/cl-gd/cl-gd.asd \
		/usr/share/common-lisp/systems/cl-gd.asd

	insinto /usr/share/common-lisp/source/cl-gd-test
	doins cl-gd-test.asd cl-gd-test.lisp
	dosym /usr/share/common-lisp/source/cl-gd-test/cl-gd-test.asd \
		/usr/share/common-lisp/systems/cl-gd-test.asd

	insinto /usr/share/common-lisp/source/cl-gd/test
	doins test/*
	insinto /usr/share/common-lisp/source/cl-gd/test/orig
	doins test/orig/*

	dodoc CHANGELOG README
	dohtml doc/*
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/{cl-gd,cl-gd-test} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/{cl-gd,cl-gd-test} || true
}

pkg_postinst() {
	/usr/sbin/register-common-lisp-source cl-gd
	/usr/sbin/register-common-lisp-source cl-gd-test
	einfo "To run the test suite, you will need to adjust permissions on the test"
	einfo "images located in /usr/share/common-lisp/source/cl-gd/test or relocate"
	einfo "the images and set cl-gd-test:*test-directory* appropriately."
}

pkg_prerm() {
	/usr/sbin/unregister-common-lisp-source cl-gd
	/usr/sbin/unregister-common-lisp-source cl-gd-test
}
