# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.5-r3.ebuild,v 1.2 2002/03/06 18:55:22 gbevin Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Enlightenment Window Manager"
SRC_URI="ftp://ftp.enlightenment.org/enlightenment/enlightenment/${P}.tar.gz"
HOMEPAGE="http://www.enlightenment.org/"

DEPEND=">=media-libs/fnlib-0.5
	>=media-sound/esound-0.2.19
	~media-libs/freetype-1.3.1
	>=gnome-base/libghttp-1.0.9-r1"


src_compile() {
  
	./configure --host=${CHOST} 			\
		    --enable-fsstd					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man			\
		    --infodir=/usr/share/info || die
	emake || die
}

src_install() {

	mv man/Makefile man/Makefile_orig
	sed -e "s:DESTDIR =:DESTDIR = ${D}:" man/Makefile_orig > man/Makefile
	make prefix=${D}/usr 					\
		localedir=${D}/usr/share/locale		\
		gnulocaledir=${D}/usr/share/locale	\
		mandir=${D}/usr/share/man			\
		infodir=${D}/usr/share/info			\
		install || die
  
	doman man/enlightenment.1
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING FAQ INSTALL NEWS README
	docinto sample-scripts
	dodoc sample-scripts/*
	
	exeinto /etc/X11/Sessions
	doexe $FILESDIR/enlightenment
	
}



