# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-6.50-r3.ebuild,v 1.1 2002/01/01 22:34:52 azarah Exp $

GPV="4.1.1"
JPEG=jpegsrc.v6b.tar.gz
ZLIB=zlib-1.1.3.tar.gz
LIBPNG=libpng-1.0.12.tar.gz

S=${WORKDIR}/gs${PV}
DESCRIPTION="Aladdin Ghostscript"
SRC_URI="http://download.sourceforge.net/ghostscript/${P}.tar.gz
	http://download.sourceforge.net/gs-fonts/ghostscript-fonts-std-6.0.tar.gz
	http://download.sourceforge.net/gimp-print/print-${GPV}.tar.gz
	ftp://ftp.uu.net/graphics/jpeg/${JPEG}
	ftp://swrinde.nde.swri.edu/pub/png/src/${LIBPNG}
	ftp://ftp.freesoftware.com/pub/infozip/zlib/${ZLIB}"

DEPEND="virtual/glibc
	virtual/x11"


src_unpack() {

	unpack ${A}
	
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-time_.h-gentoo.diff || die
	#touch src/gdevstp-print.h

	local tmpdir=${JPEG/src.v/-}
	tmpdir=${tmpdir/.tar.gz/}
	mv ${WORKDIR}/${tmpdir} ${S}/jpeg
	
	tmpdir=${ZLIB/.tar.gz/}
	mv ${WORKDIR}/${tmpdir} ${S}/zlib

	tmpdir=${LIBPNG/.tar.gz/}
	mv ${WORKDIR}/${tmpdir} ${S}/libpng
	
	cd ${WORKDIR}/print-${GPV}/Ghost
	cp *.{c,h} ${S}/src
	cat contrib.mak.addon >> ${S}/src/contrib.mak
	
	cd ${S}/src
	cp unix-gcc.mak unix-gcc.mak.orig
	sed -e "s:^DEVICE_DEVS6=:DEVICE_DEVS6=\$\(DD\)stp\.dev :" \
		-e "s:CFLAGS_STANDARD=-O2:CFLAGS_STANDARD=${CFLAGS}:" \
		-e "s:XLIBDIRS=-L/usr/X11/lib:XLIBDIRS=-L/usr/X11R6/lib:" \
		-e "s:XLIBS=Xt Xext X11:XLIBS=Xt SM ICE Xext X11:" \
		unix-gcc.mak.orig > unix-gcc.mak
}

src_compile() {

	cd ${S}
	ln -sf src/unix-gcc.mak Makefile
	make prefix=/usr || die
	
	cd ${WORKDIR}/print-${GPV}/Ghost
	make || die
}

src_install() {

	dodir /usr/{bin,share/man/man1}
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die

	mv ${D}/usr/bin/gs ${D}/usr/bin/gs-${PV}
	dosym /usr/bin/gs-${PV} /usr/bin/gs

	cd ${WORKDIR}
	cp -a fonts ${D}/usr/share/ghostscript
	cd ${S}

	dodir /usr/share/doc/${PF}
	rm -rf ${D}/usr/share/ghostscript/${PV}/doc
	dodoc doc/README doc/PUBLIC
	docinto html
	dodoc doc/*.html doc/*.htm
	insinto /usr/share/emacs/site-lisp
	doins doc/gsdoc.el

	cd ${WORKDIR}/print-${GPV}/Ghost
	dobin escputil
	docinto stp
	dodoc README* COPYING ChangeLog
}
