# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gantoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegro/allegro-4.0.1.ebuild,v 1.3 2002/05/27 17:27:38 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Allegro is a cross-platform multimedia library"
SRC_URI="mirror://sourceforge/alleg/${P}.tar.gz"
HOMEPAGE="http://alleg.sourceforge.net/"

DEPEND="X? ( virtual/x11 )"

src_compile() {
	
	confopts="--infodir=/usr/share/info	\
		--mandir=/usr/share/man \
		--prefix=/usr \
		--host=${CHOST}"
	
	# Always enable Linux console support and accompanying drivers
	confopts="${confopts} --enable-linux --enable-vga"
	
	# if USE static defined, use static library as default to link with
	use static \
		&& confopts="${confopts} --enable-staticprog --enable-static"
	
	# Pentium optimizations
	if [ ${CHOST} = "i586-pc-linux-gnu" -o ${CHOST} = "i686-pc-linux-gnu" ]
	then 
		confopts="${confopts} --enable-pentiumopts"
	fi
	
	# Use MMX instructions
	use mmx \
		&& confopts="${confopts} --enable-mmx" \
		|| confopts="${confopts} --enable-mmx=no"
	
	# Have OSS support
	use oss \
		&& confopts="${confopts} --enable-ossdigi --enable-ossmidi" \
		|| confopts="${confopts} --disable-ossdigi --disable-ossmidi"
	
	# Have ALSA support
	use alsa \
		&& confopts="${confopts} --enable-alsadigi --enable-alsamidi" \
		|| confopts="${confopts} --disable-alsadigi --disable-alsamidi"
	
	# Have ESD support
	use esd \
		&& confopts="${confopts} --enable-esddigi" \
		|| confopts="${confopts} --disable-esddigi"
	
	# Have X11 support
	use X \
		&& confopts="${confopts} \
			--with-x \
			--enable-xwin-shm \
			--enable-xwin-vidmode \
			--enable-xwin-dga \
			--enable-xwin-dga2" \
		|| confopts="${confopts} --without-x \
			--disable-xwin-shm \
			--disable-xwin-vidmode \
			--disable-xwin-dga \
			--disable-xwin-dga2"
	
	# Have SVGALib support
	use svga \
		&& confopts="${confopts} --enable-svgalib" \
		|| confopts="${confopts} --disable-svgalib"
	
	# Have fbcon support
	use fbcon \
		&& confopts="${confopts} --enable-fbcon" \
		|| confopts="${confopts} --disable-fbcon"

	# --------------

	./configure \
		${confopts} || die
	
	# emake doesn't work
	make || die
	
	make docs-ps docs-dvi || die
	
}

src_install () {
	
	make \
		prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install install-gzipped-man install-gzipped-info || die
	
	cd ${S}
	# Different format versions of the Allegro documentation
	dohtml allegro.dvi allegro.ps
	dodoc allegro.txt 
	
}
