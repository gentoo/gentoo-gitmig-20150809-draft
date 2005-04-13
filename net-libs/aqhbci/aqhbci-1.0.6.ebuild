# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/aqhbci/aqhbci-1.0.6.ebuild,v 1.1 2005/04/13 07:04:49 hanno Exp $

DESCRIPTION="HBCI backend for AqBanking"
HOMEPAGE="http://www.aquamaniac.de/aqbanking/"
SRC_URI="mirror://sourceforge/aqhbci/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
IUSE="debug"
DEPEND=">=net-libs/aqbanking-1.0.8"
S=${WORKDIR}/${P}

# Fails with parallel make
MAKEOPTS="-j1"

src_compile() {
	econf `use_enable debug` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS README TODO README COPYING NEWS
}
