# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openh323/openh323-1.9.3.ebuild,v 1.5 2003/02/13 14:21:22 vapier Exp $

SRC_URI="http://www.openh323.org/bin/openh323_${PV}.tar.gz"
HOMEPAGE="http://www.openh323.org"
DESCRIPTION="Open Source implementation of the ITU H.323 teleconferencing protocol"

SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="x86 sparc "

DEPEND=">=dev-libs/pwlib-1.3.3"

S="${WORKDIR}/${PN}"

src_compile() {
	export PWLIBDIR=/usr/share/pwlib
	export OPENH323DIR=${S}
	echo $PWLIBDIR
	make optshared || die
}

src_install() {
	dodir /usr/lib /usr/share/openh323
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
