# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xsupplicant/xsupplicant-0.8b.ebuild,v 1.7 2009/05/09 16:48:55 volkmar Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="Open Source Implementation of IEEE 802.1x"
SRC_URI="mirror://sourceforge/open1x/${P}.tar.gz"
HOMEPAGE="http://open1x.sourceforge.net"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=dev-libs/openssl-0.9.7
	virtual/libpcap
	>=dev-libs/libdnet-1.6"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die "configure failed"
	# does *NOT* like emake.
	make || die "failed to compile"
}

src_install() {
	make DESTDIR="${D}" install || die "installation failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README README.wireless_cards \
		doc/README.certificates
}
