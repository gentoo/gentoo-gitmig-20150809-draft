# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="fbi a framebuffer image viewer"
SRC_URI="http://www.strusel007.de/linux/misc/`echo ${P} |sed -e 's:-:_:'`.tar.gz"
HOMEPAGE="http://www.strusel007.de/linux/fbi.html"

DEPEND=">=media-libs/jpeg-6b"


src_unpack() {

	unpack ${A}
	
	cd ${S}/src
	sed -e "s:-O2:${CFLAGS}:" Makefile |cat >Makefile
	
	cd ${S}/libpcd
	sed -e "s:-O2:${CFLAGS}:" Makefile |cat >Makefile
}

src_compile() {

	make CC=gcc || die
}

src_install() {

	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man/man1				\
	     install || die
	
	dodoc COPYING README

}
