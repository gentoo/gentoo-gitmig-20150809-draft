# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vtun/vtun-3.0.2.ebuild,v 1.1 2009/04/19 17:23:02 rbu Exp $

EAPI=2
DESCRIPTION="Create virtual tunnels over TCP/IP networks with traffic shaping, encryption, and compression."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://vtun.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="lzo socks5 ssl zlib"

RDEPEND="ssl? ( dev-libs/openssl )
	lzo? ( dev-libs/lzo:2 )
	zlib? ( sys-libs/zlib )
	socks5? ( net-proxy/dante )"
DEPEND="${RDEPEND}
	sys-devel/bison"

src_configure() {
	econf $(use_enable ssl) \
		$(use_enable zlib) \
		$(use_enable lzo) \
		$(use_enable socks5 socks) \
		--enable-shaper
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
}
