# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/qadsl/qadsl-1.3.2.ebuild,v 1.2 2004/04/04 09:31:27 dholm Exp $

DESCRIPTION="qADSL is an autologin & keep-alive daemon for various WAN/LAN/ADSL connections provided by several (mainly Swedish) ISPs."
HOMEPAGE="http://www.nongnu.org/qadsl"
SRC_URI="http://savannah.nongnu.org/download/qadsl/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND=""
#RDEPEND=""

src_compile() {
	econf ||die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog CREDITS HACKING NEWS README TODO
}
