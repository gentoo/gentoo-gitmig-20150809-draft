# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hlfl/hlfl-0.60.1.ebuild,v 1.2 2003/10/24 16:10:38 lanius Exp $

DESCRIPTION="High Level Firewall Language"
SRC_URI="ftp://ftp.hlfl.org/pub/hlfl/${P}.tar.gz"
HOMEPAGE="http://www.hlfl.org"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	econf --datadir=/usr/share/doc/${P} || die "./configure failed"
	emake || die
}

src_install () {
	dobin src/hlfl
	doman doc/hlfl.1
	insinto /usr/share/doc/${P}
	doins doc/services.hlfl /usr/share/doc/${P}

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS \
	TODO doc/RoadMap doc/sample_1.hlfl doc/sample_2.hlfl \
	doc/test.hlfl doc/syntax.txt
}
