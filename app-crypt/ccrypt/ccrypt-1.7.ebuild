# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccrypt/ccrypt-1.7.ebuild,v 1.3 2004/12/21 16:18:46 ndimiduk Exp $

DESCRIPTION="Encryption and decryption"
HOMEPAGE="http://ccrypt.sourceforge.net"
SRC_URI="http://ccrypt.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~ppc-macos"
IUSE=""
RDEPEND="virtual/libc"
DEPEND="virtual/libc
	sys-apps/gawk"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	emake \
		DESTDIR=${D} \
		htmldir=/usr/share/doc/${PF} \
		install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
