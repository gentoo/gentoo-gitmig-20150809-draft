# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/pspell/pspell-0.12.2-r1.ebuild,v 1.5 2002/05/27 17:27:36 drobbins Exp $

#Remove leading zero from version number
MYPV=${PV#0}

S=${WORKDIR}/${PN}-${MYPV}

DESCRIPTION="A spell checker frontend for aspell and ispell"

SRC_URI="mirror://sourceforge/${PN}/${PN}-${MYPV}.tar.gz"

HOMEPAGE="http://pspell.sourceforge.net"

DEPEND="virtual/glibc"


src_compile() {

	./configure \
		--prefix=/usr \
		--enable-doc-dir=/usr/share/doc/${PF} \
		--host=${CHOST} || die "./configure failed"
		
	emake || die "Parallel Make Failed"
	cd modules
	./configure \
		--prefix=/usr \
		--host=${CHOST} || die "Modules config failed"
	emake || die "Modules compilation filed"

}

src_install () {

	make DESTDIR=${D} install || die "Installation Failed"
    
	dodoc README*
    
	cd ${D}/usr/share/doc/${PF}
	mv man-html html
	mv man-text txt

}
