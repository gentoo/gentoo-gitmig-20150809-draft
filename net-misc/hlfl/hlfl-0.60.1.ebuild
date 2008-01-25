# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hlfl/hlfl-0.60.1.ebuild,v 1.9 2008/01/25 20:20:21 armin76 Exp $

IUSE=""
DESCRIPTION="High Level Firewall Language"
SRC_URI="ftp://ftp.hlfl.org/pub/hlfl/${P}.tar.gz"
HOMEPAGE="http://www.hlfl.org"
LICENSE="GPL-2"
KEYWORDS="~ppc sparc x86"
SLOT="0"

DEPEND="virtual/libc"

src_compile() {
	sed -i -e 's:${datadir}/hlfl:${datadir}:' configure
	econf --datadir=/usr/share/doc/${P} || die "./configure failed"
	emake || die
}

src_install () {
	dobin src/hlfl
	doman doc/hlfl.1
	insinto /usr/share/doc/${P}
	doins doc/services.hlfl

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS \
	TODO doc/RoadMap doc/sample_1.hlfl doc/sample_2.hlfl \
	doc/test.hlfl doc/syntax.txt doc/sample_3.hlfl doc/CodingStyle
}
