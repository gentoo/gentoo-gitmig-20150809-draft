# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/znc/znc-0.080.ebuild,v 1.4 2010/04/13 11:53:37 phajdan.jr Exp $

DESCRIPTION="An advanced IRC Bouncer"
HOMEPAGE="http://znc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="ares debug extras ipv6 nomodules perl ssl sasl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.7d )
	perl? ( dev-lang/perl )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	ares? ( net-dns/c-ares )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable extras extra) \
		$(use_enable ipv6) \
		$(use_enable !nomodules modules) \
		$(use_enable perl) \
		$(use_enable ssl openssl) \
		$(use_enable sasl) \
		$(use_enable ares c-ares) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed."
	dodoc AUTHORS || die "dodoc failed"
}

pkg_postinst() {
	elog
	elog "Run 'znc --makeconf' as the user you want to run ZNC as"
	elog "to make a configuration file"
	elog "If you are using SSL you should also run 'znc --makepem'"
	elog
}
