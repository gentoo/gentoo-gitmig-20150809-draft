# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit libtool motif

DESCRIPTION="An OSF/Motif(R) clone"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.lesstif.org/"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
SLOT="1.2"

DEPEND="virtual/glibc
	virtual/x11"

src_compile() {
	elibtoolize

	econf \
	  --enable-build-12 \
	  --disable-build-20 \
	  --disable-build-21 \
	  --enable-static \
	  --enable-shared \
	  --enable-production \
	  --enable-verbose=no \
	  --with-x || die "./configure failed"

	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die "make install"


	einfo "Fixing binaries"
	for file in `ls ${D}/usr/bin`
	do
		mv ${D}/usr/bin/${file} ${D}/usr/bin/${file}-1.2
	done


	einfo "Fixing docs"
	dodir /usr/share/doc/
	mv ${D}/usr/LessTif ${D}/usr/share/doc/${P}


	einfo "Fixing libraries"
	dodir /usr/lib/motif/1.2
	mv ${D}/usr/lib/lib* ${D}/usr/lib/motif/1.2

	for lib in libMrm.so.1 libMrm.so.1.0.2 \
		libUil.so.1 libUil.so.1.0.2 \
		libXm.so.1  libXm.so.1.0.2
	do
		dosym "/usr/lib/motif/1.2/${lib}"\
			"/usr/lib/${lib}"
	done


	einfo "Fixing includes"
	dodir /usr/include/Mrm/1.2/Mrm
	dodir /usr/include/Xm/1.2/Xm
	dodir /usr/include/uil/1.2/uil

	mv ${D}/usr/include/Mrm/*.h ${D}/usr/include/Mrm/1.2/Mrm
	mv ${D}/usr/include/Xm/*.h ${D}/usr/include/Xm/1.2/Xm
	mv ${D}/usr/include/uil/*.{h,uil} ${D}/usr/include/uil/1.2/uil

	cd ${D}/usr/include
	motif_fix_headers 1.2


	einfo "Fixing man pages"
	for file in `ls ${D}/usr/share/man/man1`
	do
		file=${file/.1/}
		mv ${D}/usr/share/man/man1/${file}.1 ${D}/usr/share/man/man1/${file}-12.1
	done
	for file in `ls ${D}/usr/share/man/man3`
	do
		file=${file/.3/}
		mv ${D}/usr/share/man/man3/${file}.3 ${D}/usr/share/man/man3/${file}-12.3
	done
	for file in `ls ${D}/usr/share/man/man5`
	do
		file=${file/.5/}
		mv ${D}/usr/share/man/man5/${file}.5 ${D}/usr/share/man/man5/${file}-12.5
	done

	einfo "Cleaning up"
	rm -fR ${D}/usr/lib/LessTif
	rm -fR ${D}/usr/lib/X11
	rm -f  ${D}/bin/mxmkmf-1.2
}
