# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mcrypt/mcrypt-2.6.2.ebuild,v 1.1 2002/10/31 16:07:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="mcrypt is intended to be a replacement of the old unix crypt(1)"
SRC_URI="ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/${P}.tar.gz"
HOMEPAGE="http://mcrypt.hellug.gr/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"

DEPEND=">=dev-libs/libmcrypt-2.5.1
	>=app-crypt/mhash-0.8.15"

src_compile() {

	local myconf

	use nls || myconf="--disable-nls"

	econf ${myconf}
	emake || die
}


src_install () {
	einstall || die
	dodoc README NEWS AUTHORS COPYING THANKS TODO 
}
