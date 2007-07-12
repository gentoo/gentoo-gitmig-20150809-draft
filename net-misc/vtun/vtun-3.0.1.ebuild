# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vtun/vtun-3.0.1.ebuild,v 1.4 2007/07/12 02:52:15 mr_bones_ Exp $

DESCRIPTION="Create virtual tunnels over TCP/IP networks with traffic shaping, encryption, and compression."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://vtun.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="lzo socks5 ssl zlib"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6c )
	lzo? ( >=dev-libs/lzo-2 )
	zlib? ( sys-libs/zlib )
	socks5? ( net-proxy/dante )"
DEPEND="${RDEPEND}
	sys-devel/bison"

src_compile() {
	econf $(use_enable ssl) \
		$(use_enable zlib) \
		$(use_enable lzo) \
		$(use_enable socks5 socks) \
		--enable-shaper
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog Credits FAQ README README.Setup README.Shaper TODO
	newinitd "${FILESDIR}"/vtun.rc vtun
	insinto etc
	doins "${FILESDIR}"/vtund-start.conf
}

pkg_postinst() {
	elog "You will need the Universal TUN/TAP driver compiled into"
	elog "your kernel or as a module to use the associated tunnel"
	elog "modes in vtun."
	elog
	elog "Also note that vtun-3 is not compatible with vtun-2."
}
