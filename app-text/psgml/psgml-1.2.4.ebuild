# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/psgml/psgml-1.2.4.ebuild,v 1.4 2002/08/02 17:42:49 phoenix Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PSGML is a GNU Emacs Major Mode for editing SGML and XML coded documents."
SRC_URI="http://ftp1.sourceforge.net/${PN}/${P}.tar.gz"
HOMEPAGE="http://psgml.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/emacs"

src_compile() {

	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--host=${CHOST} || die "Configuration failed."
		
	emake || die "parallel make failed."

}

src_install () {

	make prefix=${D}/usr install || die "Installation failed."
	
	dodir /usr/share/info
    
	make infodir=${D}/usr/share/info install-info || die "install-info failed."

	dodoc ChangeLog README.psgml ${FILESDIR}/dot_emacs

}

