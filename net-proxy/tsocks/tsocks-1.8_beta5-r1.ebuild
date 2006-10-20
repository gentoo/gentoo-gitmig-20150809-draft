# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/tsocks/tsocks-1.8_beta5-r1.ebuild,v 1.5 2006/10/20 20:57:50 gustavoz Exp $

inherit multilib eutils autotools toolchain-funcs

DESCRIPTION="Transparent SOCKS v4 proxying library"
HOMEPAGE="http://tsocks.sourceforge.net/"
SRC_URI="mirror://sourceforge/tsocks/${PN}-${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/${P%%_*}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-bsd.patch"
	eautoconf
}

src_compile() {
	tc-export CC

	# NOTE: the docs say to install it into /lib. If you put it into
	# /usr/lib and add it to /etc/ld.so.preload on many systems /usr isn't
	# mounted in time :-( (Ben Lutgens) <lamer@gentoo.org>
	econf \
		--with-conf=/etc/socks/tsocks.conf \
		--libdir=/$(get_libdir) \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dobin validateconf inspectsocks saveme
	insinto /etc/socks
	doins tsocks.conf.*.example
	# tsocks script is buggy so we need this symlink
	dodir /usr/$(get_libdir)
	dosym /$(get_libdir)/libtsocks.so /usr/$(get_libdir)/libtsocks.so
}

pkg_postinst() {
	einfo "Make sure you create /etc/socks/tsocks.conf from one of the examples in that directory"
}
