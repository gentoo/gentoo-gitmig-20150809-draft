# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>, Geert Bevin <gbevin@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostscript/ghostscript-6.53-r2.ebuild,v 1.1 2002/04/28 18:40:09 jnelson Exp $

GPV="4.2.1"

JPEG=jpegsrc.v6b.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU Ghostscript"
SRC_URI="http://download.sourceforge.net/ghostscript/${P}.tar.bz2
	http://download.sourceforge.net/gs-fonts/ghostscript-fonts-std-6.0.tar.gz
	http://download.sourceforge.net/gimp-print/gimp-print-${GPV}.tar.gz
	ftp://ftp.uu.net/graphics/jpeg/${JPEG}"

# NOTES:
# Why aren't we using configure (for ghostscript)?

# When I run configure (for gimp-print), there are some questions:
#
# Which of the following do we want to say 'yes'?
# checking whether to build CUPS driver... no
# checking whether to build translated CUPS PPD files... yes
# checking whether to use level 3 PostScript... no
# checking whether to build ghostscript driver... no
# checking whether to build foomatic data files... no
# checking whether to build GIMP plugin... no
# 
# and no?
# checking whether to build escputil... yes
# checking whether to build libgimpprint... yes

DEPEND="virtual/glibc
	virtual/x11
        sys-libs/zlib
        media-libs/libpng
        media-libs/jpeg"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}
	
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gdi-gentoo.diff || die
	patch -p1 < ${FILESDIR}/${P}-r2-gimpprint-gentoo.diff || die
	cp ${FILESDIR}/gdevgdi.c ${S}/src || die
        
        # additional patches taken from the PLD SRPM
	# fix some shellscripts to wrap their filename arguments in double-quotes
        patch -p1 < ${FILESDIR}/${P}-missquotes.patch || die
	# when using svga output, save and restore the uid because
	# ghostscript needs to be setuid. This make gs only be suid
	# only as long as necessary.
        patch -p1 < ${FILESDIR}/${P}-setuid.patch || die
        
        # a patch right from HP to fix some margin issues with deskjets
	patch -p1 < ${FILESDIR}/${P}-hpdj_margins.patch || die

	local tmpdir=${JPEG/src.v/-}
	tmpdir=${tmpdir/.tar.gz/}
	mv ${WORKDIR}/${tmpdir} ${S}/jpeg || die
	
#	tmpdir=${ZLIB/.tar.bz2/}
#	mv ${WORKDIR}/${tmpdir} ${S}/zlib || die

#	tmpdir=${LIBPNG/.tar.bz2/}
#	mv ${WORKDIR}/${tmpdir} ${S}/libpng || die

	cd ${WORKDIR}/gimp-print-${GPV}
	./configure --without-gimp --enable-static --disable-shared || die
	cd ${WORKDIR}/gimp-print-${GPV}/src/ghost
	cp *.c ${S}/src || die
	cd ${WORKDIR}/gimp-print-${GPV}/include/gimp-print
	mkdir ${S}/src/gimp-print
	cp *.h ${S}/src/gimp-print || die
	cat contrib.mak.addon >> ${S}/src/contrib.mak
	
	cd ${S}/src
	cp unix-gcc.mak unix-gcc.mak.orig
	sed -e "s:^DEVICE_DEVS6=:DEVICE_DEVS6=\$\(DD\)stp\.dev :" \
        	-e "s:SHARE_LIBPNG=0:SHARE_LIBPNG=1:" \
        	-e "s:SHARE_ZLIB=0:SHARE_ZLIB=1:" \
		-e "s:CFLAGS_STANDARD=-O2:CFLAGS_STANDARD=${CFLAGS}:" \
		-e "s:XLIBDIRS=-L/usr/X11/lib:XLIBDIRS=-L/usr/X11R6/lib:" \
		-e "s:XLIBS=Xt Xext X11:XLIBS=Xt SM ICE Xext X11:" \
		unix-gcc.mak.orig > unix-gcc.mak
}

src_compile() {

	cd ${WORKDIR}/gimp-print-${GPV}
	emake || die

	cd ${S}
	ln -sf src/unix-gcc.mak Makefile
	emake prefix=/usr || die
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
	dodoc doc/README doc/PUBLIC doc/COPYING*
	dohtml doc/*
	insinto /usr/share/emacs/site-lisp
	doins doc/gsdoc.el

	cd ${WORKDIR}/gimp-print-${GPV}
	dobin src/escputil/escputil
	docinto stp
	dodoc README* COPYING ChangeLog
}
