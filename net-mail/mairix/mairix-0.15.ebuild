# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mairix/mairix-0.15.ebuild,v 1.6 2005/02/04 13:19:42 tove Exp $

DESCRIPTION="Indexes and searches Maildir/MH folders"
HOMEPAGE="http://www.rpcurnow.force9.co.uk/mairix/"
SRC_URI="http://www.rpcurnow.force9.co.uk/mairix/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND="virtual/libc
	>=sys-apps/texinfo-4.2"
RDEPEND="virtual/libc"

src_compile() {
	./configure \
		    --prefix=/usr \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
		    --docdir=/usr/share/doc/${PF} || die
	emake all mairix.info || die
}

src_install() {
	dobin mairix
	doinfo mairix.info
	dodoc NEWS README mairix.txt
}
