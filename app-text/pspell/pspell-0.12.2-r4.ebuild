# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/pspell/pspell-0.12.2-r4.ebuild,v 1.1 2002/08/23 15:43:51 seemant Exp $

inherit libtool

#Remove leading zero from version number
MYPV=${PV#0}
S=${WORKDIR}/${PN}-${MYPV}
DESCRIPTION="A spell checker frontend for aspell and ispell"
SRC_URI="http://telia.dl.sf.net/${PN}/${PN}-${MYPV}.tar.gz" #2481
HOMEPAGE="http://pspell.sourceforge.net"

DEPEND=">=app-text/aspell-0.50"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {

	elibtoolize
	econf \
		--libdir=/usr/lib/pspell \
		--enable-doc-dir=/usr/share/doc/${PF} \
		--enable-ltdl \
		|| die "./configure failed"
		
	emake || die "Parallel Make Failed"
}

src_install () {

	make \
		DESTDIR=${D} \
		install || die "Installation Failed"

	#remove things which are installed by aspell
 	rm -f ${D}/usr/bin/pspell-config
	rm -f ${D}/usr/include/pspell/pspell.h
	dodoc README*
    
	cd ${D}/usr/share/doc/${PF}
	mv man-html html
	mv man-text txt
}
