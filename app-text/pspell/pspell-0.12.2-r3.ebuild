# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/pspell/pspell-0.12.2-r3.ebuild,v 1.4 2002/08/06 14:51:24 gerk Exp $

inherit libtool

#Remove leading zero from version number
MYPV=${PV#0}
S=${WORKDIR}/${PN}-${MYPV}
DESCRIPTION="A spell checker frontend for aspell and ispell"
SRC_URI="http://telia.dl.sf.net/${PN}/${PN}-${MYPV}.tar.gz" #2481
HOMEPAGE="http://pspell.sourceforge.net"

DEPEND="virtual/glibc
	>=sys-devel/libtool-1.4.1-r4"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc"

src_compile() {

	elibtoolize
	
	econf \
		--enable-doc-dir=/usr/share/doc/${PF} \
		--enable-ltdl \
		|| die "./configure failed"
		
	emake || die "Parallel Make Failed"
}

src_install () {

	make \
		DESTDIR=${D} \
		install || die "Installation Failed"
    
	dodoc README*
    
	cd ${D}/usr/share/doc/${PF}
	mv man-html html
	mv man-text txt
}
