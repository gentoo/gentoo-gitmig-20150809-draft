# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ccrypt/ccrypt-1.7.ebuild,v 1.8 2006/08/16 00:16:50 squinky86 Exp $

DESCRIPTION="Encryption and decryption"
HOMEPAGE="http://ccrypt.sourceforge.net"
SRC_URI="http://ccrypt.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos x86"
IUSE=""
RDEPEND="virtual/libc"
DEPEND="virtual/libc
	sys-apps/gawk"

src_install () {
	emake \
		DESTDIR="${D}" \
		htmldir=/usr/share/doc/${PF} \
		install || die
	dodoc AUTHORS ChangeLog NEWS README
}
