# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccrypt/ccrypt-1.7.ebuild,v 1.1 2004/09/07 11:40:59 dragonheart Exp $

DESCRIPTION="Encryption and decryption"
HOMEPAGE="http://ccrypt.sourceforge.net"
SRC_URI="http://ccrypt.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
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
