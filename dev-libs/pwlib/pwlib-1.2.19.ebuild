# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.2.19.ebuild,v 1.1 2002/07/05 19:40:49 raker Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="Libs needed for GnomeMeeting"
SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.openh323.org"
DEPEND="virtual/glibc >=sys-devel/bison-1.28 >=sys-devel/flex-2.5.4a"
SLOT="1.2"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/pwlib-1.2.20.diff || die
}

src_compile() {
	cd ${S}
	export PWLIBDIR=${S}
	export PWLIB_BUILD="yes"
	make optshared || die
	cd tools/asnparser
	make optshared || die
}

src_install() {
	mkdir -p ${D}/usr/lib
	mkdir -p ${D}/usr/include/ptclib
	mkdir -p ${D}/usr/include/ptlib/unix/ptlib
	mkdir -p ${D}/usr/share/pwlib
	cd ${S}	
	cp -a lib/*so* ${D}/usr/lib
	cp -a include/ptlib.h ${D}/usr/include
	cp -a include/ptlib/*.h ${D}/usr/include/ptlib/
	cp -a include/ptlib/*.inl ${D}/usr/include/ptlib/	
	cp -a include/ptlib/unix/ptlib/*.h ${D}/usr/include/ptlib/unix/ptlib
	cp -a include/ptlib/unix/ptlib/*.inl ${D}/usr/include/ptlib/unix/ptlib
	cp -a include/ptclib/*.h ${D}/usr/include/ptclib/

	cp -a * ${D}/usr/share/pwlib/
	rm -rf ${D}/usr/share/pwlib/make/CVS
	#cp -a tools/* ${D}/usr/share/pwlib/tools/
        rm -rf ${D}/usr/share/pwlib/tools/CVS
	rm -rf ${D}/usr/share/pwlib/tools/asnparser/CVS
	rm -rf ${D}/usr/share/pwlib/src
	rm -rf ${D}/usr/share/pwlib/include/CVS
	rm -rf ${D}/usr/share/pwlib/include/ptlib/unix/CVS
	rm -rf ${D}/usr/share/pwlib/include/ptlib/CVS
	cd ${D}/usr/lib
	ln -sf libpt.so.${PV} libpt.so
}
