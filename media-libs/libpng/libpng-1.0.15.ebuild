# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.0.15.ebuild,v 1.1 2003/01/14 08:17:27 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Portable Networks Graphics library."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.libpng.org/"
SLOT="1.0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=sys-libs/zlib-1.1.3-r2"

src_unpack() {
	unpack ${A}
	cd ${S}

	patch -p1 < ${FILESDIR}/${P}-gentoo.diff

	sed -e "s:ZLIBLIB=../zlib:ZLIBLIB=/usr/lib:" \
		-e "s:ZLIBINC=../zlib:ZLIBINC=/usr/include:" \
		-e "s:prefix=/usr:prefix=${D}/usr:" \
		-e "s/-O3/${CFLAGS}/" \
		scripts/makefile.linux > Makefile

}

src_compile() {
	make || die
}

src_install() {
	dodir /usr/{include,lib}
	make install prefix=${D}/usr || die
	
	newman libpngpf.3 libpngpf-10.3
	newman libpng.3 libpng-10.3
	newman png.5 png-10.5

	# remove stuffs so that libpng-1.2 is the system default
	rm ${D}/usr/bin/libpng-config
	rm ${D}/usr/lib/libpng.{a,so}
	rm ${D}/usr/include/{png.h,pngconf.h,libpng}
	rm -rf ${D}/usr/man
	
	dodoc ANNOUNCE CHANGES KNOWNBUG LICENSE README TODO Y2KINFO
}
