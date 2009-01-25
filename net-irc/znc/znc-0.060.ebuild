# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/znc/znc-0.060.ebuild,v 1.3 2009/01/25 15:00:55 maekke Exp $

inherit autotools

DESCRIPTION="An advanced IRC Bouncer"
HOMEPAGE="http://znc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug ipv6 nomodules perl ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.7d )
	perl? ( dev-lang/perl )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_enable !nomodules modules) \
		$(use_enable perl) \
		$(use_enable ssl openssl) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed."
	dodoc AUTHORS znc.conf || die "dodoc failed"
}

pkg_postinst() {
	elog
	elog "Run 'znc --makeconf' as the user you want to run ZNC as"
	elog "to make a configuration file"
	elog
}
