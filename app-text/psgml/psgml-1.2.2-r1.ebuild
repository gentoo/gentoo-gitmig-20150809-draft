# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/psgml/psgml-1.2.2-r1.ebuild,v 1.10 2003/09/05 22:37:22 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PSGML is a GNU Emacs Major Mode for editing SGML and XML coded documents."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://psgml.sourceforge.net"
KEYWORDS="x86 sparc "
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

