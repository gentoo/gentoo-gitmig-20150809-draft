# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pwlib/pwlib-1.3.3.ebuild,v 1.3 2002/08/01 18:46:28 seemant Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Libs needed for GnomeMeeting"
HOMEPAGE="http://www.openh323.org"
SRC_URI="http://www.openh323.org/bin/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND=">=sys-devel/bison-1.28
	>=sys-devel/flex-2.5.4a"

src_unpack() {

	unpack ${A}
	cd ${S}
	# Removes optimizations from unix make options
	# Allows the users make.conf to set optimization level
	patch -p1 < ${FILESDIR}/opts.diff || die

}

src_compile() {
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
	ln -sf libpt_linux_x86_r.so.${PV} libpt.so
}
