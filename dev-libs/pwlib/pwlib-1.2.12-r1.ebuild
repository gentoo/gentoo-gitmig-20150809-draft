# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.2.12-r1.ebuild,v 1.1 2002/03/01 22:31:41 verwilst Exp $

S="${WORKDIR}/pwlib"
SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/pwlib_1.2.12.tar.gz"
DESCRIPTION="Libs needed for GnomeMeeting"

DEPEND="virtual/glibc
	>=sys-devel/bison-1.28
	>=sys-devel/flex-2.5.4a"

src_unpack() {

	unpack pwlib_1.2.12.tar.gz
	cd ${S}/make
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff

}

src_compile() {

	export PWLIBDIR=${S}	
	cd ${S}
	make both || die

}

src_install() {

	cd ${S}/lib
	mkdir -p ${D}/usr/lib/pwlib
	cp -a * ${D}/usr/lib/pwlib/
	cd ${D}/usr/lib/pwlib/
	ln -sf libpt_linux_x86_r.so.1.2.12 libpt.so
	
	cd ${S}/include
	mkdir -p ${D}/usr/include/pwlib/ptlib
	mkdir -p ${D}/usr/include/pwlib/ptclib
	cp -a ptlib.h ${D}/usr/include/pwlib
	cd ${S}/include/ptclib
	cp -a *.h ${D}/usr/include/pwlib/ptclib
	cd ${S}/include/ptlib
        cp -a *.h ${D}/usr/include/pwlib/ptlib
	cp -a *.inl ${D}/usr/include/pwlib/ptlib
	cd ${S} 
	cp -a version.h ${D}/usr/include/pwlib

}
