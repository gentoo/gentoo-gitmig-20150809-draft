# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/app-text/pspell/pspell-0.12.ebuild,v 1.1 2001/03/20 05:53:12 achim Exp

#Remove '-ispell' from name for download subdirectory
MYPN=${PN/-ispell//}

#Remove leading zero from version number
MYPV=${PV#0}

S=${WORKDIR}/${PN}-${MYPV}

DESCRIPTION="Ispell module for pspell"

SRC_URI="http://prdownloads.sourceforge.net/${MYPN}/${PN}-${MYPV}.tar.gz"

HOMEPAGE="http://pspell.sourceforge.net"

DEPEND=">=app-text/pspell-0.12.2-r1
	app-text/ispell"


src_compile() {

	./configure \
		--disable-static \
		--prefix=/usr \
		--enable-doc-dir=/usr/share/doc/${PF} \
		--host=${CHOST} || die "./configure failed"
		
	emake || die "Parallel Make Failed"

}

src_install () {

	make DESTDIR=${D} install || die "Installation Failed"
    
	dodoc README
    
}
