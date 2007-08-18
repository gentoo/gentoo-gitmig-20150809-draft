# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/obby/obby-0.4.4.ebuild,v 1.1 2007/08/18 22:30:27 dev-zero Exp $

DESCRIPTION="Library for collaborative text editing"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="avahi ipv6"

DEPEND=">=net-libs/net6-1.3.5
		>=dev-libs/libsigc++-2.0
		>=dev-libs/gmp-4.1.4
		avahi? ( net-dns/avahi )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_with avahi zeroconf) \
		$(use_enable ipv6) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
