# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/pspell-ispell/pspell-ispell-0.12-r1.ebuild,v 1.7 2002/08/18 06:41:41 gerk Exp $

inherit libtool

#Remove '-ispell' from name for download subdirectory
MYPN=${PN/-ispell//}

#Remove leading zero from version number
MYPV=${PV#0}

S=${WORKDIR}/${PN}-${MYPV}
DESCRIPTION="Ispell module for pspell"
SRC_URI="mirror://sourceforge/${MYPN}/${PN}-${MYPV}.tar.gz"
HOMEPAGE="http://pspell.sourceforge.net"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=app-text/pspell-0.12.2-r2
	>=app-text/ispell-3.2.06-r1"


src_compile() {

	elibtoolize

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
