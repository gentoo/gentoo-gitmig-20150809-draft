# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/hlfl/hlfl-0.60.1.ebuild,v 1.1 2003/10/11 15:52:04 lanius Exp $

S=${WORKDIR}/${P}
DESCRIPTION="High Level Firewall Language"
SRC_URI="ftp://ftp.hlfl.org/pub/hlfl/${P}.tar.gz"
HOMEPAGE="http://www.hlfl.org"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"

DEPEND="virtual/glibc"

src_install () {
	einstall

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README THANKS TODO
	cd doc
	dodoc CodingStyle sample_1.hlfl sample_2.hlfl sample_3.hlfl \
		services.hlfl syntax.txt test.hlfl RoadMap TODO
	rm -f ${D}/usr/share/*
}
