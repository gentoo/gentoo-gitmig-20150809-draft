# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/psgml/psgml-1.2.4.ebuild,v 1.5 2004/06/15 09:54:20 kloeri Exp $

DESCRIPTION="PSGML is a GNU Emacs Major Mode for editing SGML and XML coded documents."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://psgml.sourceforge.net"
KEYWORDS="x86 sparc"
IUSE=""
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

