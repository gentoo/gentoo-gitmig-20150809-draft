# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-gd/cl-gd-0.4.1.ebuild,v 1.1 2004/06/01 04:56:53 mkennedy Exp $

inherit common-lisp

DESCRIPTION="CL-GD is a library for Common Lisp which interfaces ti the GD Graphics Library"
HOMEPAGE="http://weitz.de/cl-gd
	http://www.cliki.net/cl-gd"
SRC_URI="mirror://gentoo/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gif"
DEPEND="dev-lisp/common-lisp-controller
	>=dev-lisp/cl-uffi-1.3.4
	media-libs/libpng
	media-libs/jpeg
	media-libs/freetype
	>=media-libs/libgd-2.0.15
	sys-libs/zlib
	virtual/commonlisp"

CLPACKAGE=cl-gd

S=${WORKDIR}/${P}

src_compile() {
	local csource
	if use gif; then
		csource=cl-gd-glue-gif.c
		echo '(push :cl-gd-gif *features*)' >>cl-gd.asd
	else
		csource=cl-gd-glue.c
	fi
	gcc ${CFLAGS} -fPIC -c ${csource}
	ld -lgd -lz -lpng -ljpeg -lfreetype -lm -shared ${csource%.c}.o -o cl-gd-glue.so
	rm ${csource%.c}.o
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
}

pkg_prerm() {
	/usr/sbin/unregister-common-lisp-source cl-gd
	/usr/sbin/unregister-common-lisp-source cl-gd-test
}
