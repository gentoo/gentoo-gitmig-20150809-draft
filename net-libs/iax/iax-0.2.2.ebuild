# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/iax/iax-0.2.2.ebuild,v 1.7 2005/04/24 02:45:44 hansmi Exp $

IUSE=""

DESCRIPTION="IAX (Inter Asterisk eXchange) Library"
HOMEPAGE="http://www.digium.com/"
LICENSE="LGPL-2"
DEPEND="virtual/libc"
RDEPEND="virtual/libc"
SLOT="0"
SRC_URI="http://www.digium.com/pub/libiax/${P}.tar.gz"

D_PREFIX=/usr

KEYWORDS="x86 ppc"

src_compile() {
	./configure --prefix=${D_PREFIX} --enable-autoupdate

	export UCFLAGS="${CFLAGS}"

	emake || die
}

src_install () {
	make prefix=${D}/${D_PREFIX} install
	dodoc NEWS COPYING AUTHORS README
}
