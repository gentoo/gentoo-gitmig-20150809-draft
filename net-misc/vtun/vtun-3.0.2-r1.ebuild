# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vtun/vtun-3.0.2-r1.ebuild,v 1.2 2012/03/03 19:29:39 pacho Exp $

EAPI=4

inherit eutils

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

src_prepare() {
	sed -i Makefile.in \
		-e '/^LDFLAGS/s|=|+=|g' \
		|| die "sed Makefile"
	epatch "${FILESDIR}"/${P}-includes.patch
}

src_configure() {
	econf \
		$(use_enable ssl) \
		$(use_enable zlib) \
		$(use_enable lzo) \
		$(use_enable socks5 socks) \
		--enable-shaper
}

src_compile() {
	# Parallel make fails, bug 364923
	emake -j1
}

src_install() {
	emake DESTDIR="${D}" install
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
