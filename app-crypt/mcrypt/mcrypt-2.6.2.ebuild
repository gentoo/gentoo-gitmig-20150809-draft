# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mcrypt/mcrypt-2.6.2.ebuild,v 1.6 2003/06/29 22:18:39 aliz Exp $

DESCRIPTION="mcrypt is intended to be a replacement of the old unix crypt(1)"
SRC_URI="ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/${P}.tar.gz"
HOMEPAGE="http://mcrypt.hellug.gr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc "

DEPEND=">=dev-libs/libmcrypt-2.5.1
	>=app-crypt/mhash-0.8.15"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	econf ${myconf}
	emake || die
}

src_install() {
	einstall
	dodoc README NEWS AUTHORS COPYING THANKS TODO 
}
