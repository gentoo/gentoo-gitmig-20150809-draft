# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

S="${WORKDIR}/${PN}"
DESCRIPTION="Open Source Implementation of IEEE 802.1x"
SRC_URI="mirror://sourceforge/open1x/${P}.tar.gz"
HOMEPAGE="http://open1x.sourceforge.net"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"


DEPEND=">=dev-libs/openssl-0.9.7
	>=net-libs/libpcap-0.7.1
	>=dev-libs/libdnet-1.6"

src_compile() {
	econf || die "configure failed"
	# does *NOT* like emake.
	make || die "failed to compile"
}

src_install() {
	make DESTDIR=${D} install || die "installation failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.wireless_cards \
		doc/README.certificates
}
