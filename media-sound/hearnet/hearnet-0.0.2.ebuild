# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hearnet/hearnet-0.0.2.ebuild,v 1.2 2004/04/10 20:35:14 eradicator Exp $

DESCRIPTION="Listen to your network"
HOMEPAGE="http://falcon.fugal.net/~fugalh/hearnet/"
SRC_URI="http://falcon.fugal.net/~fugalh/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=net-libs/libpcap-0.4
	virtual/jack"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i 's!grain.raw!/usr/share/hearnet/grain.raw!' hearnet.c
}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	dosbin hearnet

	dodir /usr/share/hearnet
	insinto /usr/share/hearnet && doins grain.raw

	dodoc ChangeLog LICENSE README TODO
}
