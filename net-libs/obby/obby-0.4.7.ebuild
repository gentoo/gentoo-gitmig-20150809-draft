# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/obby/obby-0.4.7.ebuild,v 1.2 2010/07/20 15:10:11 jer Exp $

EAPI="2"

DESCRIPTION="Library for collaborative text editing"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="avahi ipv6 nls"

DEPEND=">=net-libs/net6-1.3.3
		dev-libs/libsigc++:2
		avahi? ( net-dns/avahi )
		nls? ( sys-devel/gettext ) "
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_with avahi zeroconf) \
		$(use_enable ipv6) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
