# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mairix/mairix-0.10.ebuild,v 1.7 2004/07/15 01:50:50 agriffis Exp $

DESCRIPTION="Indexes and searches Maildir/MH folders"
HOMEPAGE="http://www.rrbcurnow.freeuk.com/mairix/"
SRC_URI="http://www.rrbcurnow.freeuk.com/mairix/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 s390"
IUSE=""
DEPEND="virtual/libc
	>=sys-apps/texinfo-4.2"

src_compile() {
	emake prefix=/usr CFLAGS="${CFLAGS}" all mairix.info || die
}

src_install() {
	dobin mairix
	dodoc mairix.txt NEWS README
	doinfo mairix.info
}
