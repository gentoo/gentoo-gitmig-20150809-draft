# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.9.3.ebuild,v 1.2 2002/08/16 02:57:06 murphy Exp $

S="${WORKDIR}/openh323"
SRC_URI="http://www.openh323.org/bin/openh323_${PV}.tar.gz"
HOMEPAGE="http://www.openh323.org"
DESCRIPTION="Open Source implementation of the ITU H.323 teleconferencing
protocol"

DEPEND=">=dev-libs/pwlib-1.3.3"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	cd ${S}
	export PWLIBDIR=/usr/share/pwlib
	export OPENH323DIR=${S}
	echo $PWLIBDIR
	make optshared || die
}

src_install() {
   mkdir -p ${D}/usr/lib
   mkdir -p ${D}/usr/share/openh323
   cd ${S}/lib
   mv lib* ${D}/usr/lib
   cd ${S}
   cp -a * ${D}/usr/share/openh323
   rm -rf ${D}/usr/share/openh323/make/CVS
   rm -rf ${D}/usr/share/openh323/tools/CVS
   rm -rf ${D}/usr/share/openh323/tools/asnparser/CVS
   rm -rf ${D}/usr/share/openh323/src
   rm -rf ${D}/usr/share/openh323/include/CVS
   rm -rf ${D}/usr/share/openh323/include/ptlib/unix/CVS
   rm -rf ${D}/usr/share/openh323/include/ptlib/CVS

   cd ${D}/usr/lib
   ln -sf libh323_linux_x86_r.so.${PV} libopenh323.so
}


