# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-6.50-r3.ebuild,v 1.1 2002/01/01 22:34:52 azarah Exp

GPV="4.1.1"
JPEG=jpegsrc.v6b.tar.gz
ZLIB=zlib-1.1.3.tar.gz
LIBPNG=libpng-1.0.12.tar.gz
HPIJS=hpijs-1.0.2.tar.gz

S=${WORKDIR}/gs${PV}
DESCRIPTION="Aladdin Ghostscript"
SRC_URI="http://download.sourceforge.net/ghostscript/${P}.tar.gz
	http://download.sourceforge.net/gs-fonts/ghostscript-fonts-std-6.0.tar.gz
	http://download.sourceforge.net/gimp-print/print-${GPV}.tar.gz
	ftp://ftp.uu.net/graphics/jpeg/${JPEG}
	ftp://swrinde.nde.swri.edu/pub/png/src/${LIBPNG}
	ftp://ftp.freesoftware.com/pub/infozip/zlib/${ZLIB}
	http://prdownloads.sourceforge.net/hpinkjet/${HPIJS}"

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

	tmpdir=${HPIJS/.tar.gz/}
	mv ${WORKDIR}/${tmpdir}/gdevijs.c ${S}/src/
	mv ${WORKDIR}/${tmpdir}/gdevijs.h ${S}/src/
	mv ${WORKDIR}/${tmpdir}/ijs.c ${S}/src/
	mv ${WORKDIR}/${tmpdir}/ijs.h ${S}/src/
	mv ${WORKDIR}/${tmpdir}/ijs_client.c ${S}/src/
	mv ${WORKDIR}/${tmpdir}/ijs_client.h ${S}/src/
	mv ${WORKDIR}/${tmpdir}/ijs_exec_unix.c ${S}/src/
	mv ${WORKDIR}/${tmpdir}/unistd_.h ${S}/src/
	
	cd ${WORKDIR}/print-${GPV}/Ghost
	cp *.{c,h} ${S}/src
	cat contrib.mak.addon >> ${S}/src/contrib.mak
	
	cd ${S}/src
	cp unix-gcc.mak unix-gcc.mak.orig
	sed -e "s:^DEVICE_DEVS6=:DEVICE_DEVS6=\$\(DD\)stp\.dev :" \
		-e "s:CFLAGS_STANDARD=-O2:CFLAGS_STANDARD=${CFLAGS}:" \
		-e "s:XLIBDIRS=-L/usr/X11/lib:XLIBDIRS=-L/usr/X11R6/lib:" \
		-e "s:XLIBS=Xt Xext X11:XLIBS=Xt SM ICE Xext X11:" \
		-e "s:\$(DD)cdj550.dev:\$(DD)cdj550.dev \$(DD)ijs.dev:" \
		unix-gcc.mak.orig > unix-gcc.mak



	cp contrib.mak contrib.mak.orig

	echo "### ------------- IJS Interface -------------- ###" >> contrib.mak.orig
	echo "ijs_=\$(GLOBJ)gdevijs.\$(OBJ) \$(GLOBJ)ijs_client.\$(OBJ) \$(GLOBJ)ijs_exec_unix.\$(OBJ) \$(GLOBJ)ijs.\$(OBJ)" >> contrib.mak.orig
	echo "\$(GLOBJ)ijs_client.\$(OBJ) : \$(GLSRC)ijs_client.c \$(PDEVH)" >> contrib.mak.orig
	echo "	\$(GLCC) \$(GLO_)ijs_client.\$(OBJ) \$(C_) \$(GLSRC)ijs_client.c" >> contrib.mak.orig
	echo "\$(GLOBJ)ijs_exec_unix.\$(OBJ) : \$(GLSRC)ijs_exec_unix.c \$(PDEVH)" >> contrib.mak.orig
	echo "	\$(GLCC) \$(GLO_)ijs_exec_unix.\$(OBJ) \$(C_) \$(GLSRC)ijs_exec_unix.c" >> contrib.mak.orig
	echo "\$(GLOBJ)ijs.\$(OBJ) : \$(GLSRC)ijs.c \$(PDEVH)" >> contrib.mak.orig
	echo "	\$(GLCC) \$(GLO_)ijs.\$(OBJ) \$(C_) \$(GLSRC)ijs.c" >> contrib.mak.orig
	echo "\$(GLOBJ)gdevijs.\$(OBJ) : \$(GLSRC)gdevijs.c \$(PDEVH)" >> contrib.mak.orig
	echo "	\$(GLCC) \$(GLO_)gdevijs.\$(OBJ) \$(C_) \$(GLSRC)gdevijs.c" >> contrib.mak.orig
	echo "\$(DD)ijs.dev : \$(ijs_) \$(DD)page.dev" >> contrib.mak.orig
	echo "	\$(SETPDEV) \$(DD)ijs \$(ijs_)" >> contrib.mak.orig
	cp contrib.mak.orig contrib.mak

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
