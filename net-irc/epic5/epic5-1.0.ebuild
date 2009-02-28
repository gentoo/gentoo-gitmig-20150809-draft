# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic5/epic5-1.0.ebuild,v 1.2 2009/02/28 23:38:55 patrick Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Epic5 IRC Client"
SRC_URI="ftp://ftp.epicsol.org/pub/epic/EPIC5-PRODUCTION/${P}.tar.bz2"
HOMEPAGE="http://epicsol.org/"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="iconv ipv6 perl ssl tcl socks5"

DEPEND=">=sys-libs/ncurses-5.6-r2
	iconv? ( sys-libs/glibc )
	perl? ( >=dev-lang/perl-5.8.8-r2 )
	ssl? ( >=dev-libs/openssl-0.9.8e-r3 )
	tcl? ( dev-lang/tcl )
	socks5? ( net-proxy/dante )"
# ruby? ( >=dev-lang/ruby-1.8.6_p287-r1 ) # fails at the moment

src_unpack() {
	unpack ${A}
}

src_compile() {
	econf \
		--libexecdir=/usr/lib/misc \
		$(use_with iconv) \
		$(use_with ipv6) \
		$(use_with perl) \
		$(use_with ssl) \
		$(use_with tcl tcl) \
		$(use_with socks5) \
		|| die "econf failed"
	# $(use_with ruby) fails at the moment

	# parallel build failure
	emake -j1 CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	einstall \
		sharedir="${D}"/usr/share \
		libexecdir="${D}"/usr/lib/misc || die "einstall failed"

	dodoc BUG_FORM COPYRIGHT README KNOWNBUGS VOTES

	cd "${S}"/doc
	docinto doc
	dodoc \
		*.txt colors EPIC* IRCII_VERSIONS local_vars missing new-load \
		nicknames outputhelp README.SSL SILLINESS TS4
}
