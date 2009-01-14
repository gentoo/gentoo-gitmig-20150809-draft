# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ezbounce/ezbounce-1.99.14.ebuild,v 1.2 2009/01/14 03:59:50 vapier Exp $

inherit eutils

DESCRIPTION="a small IRC bouncer"
HOMEPAGE="http://www.linuxftw.com/ezbounce/"
SRC_URI="http://www.linuxftw.com/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl boost"
RESTRICT="test"

DEPEND=">=net-misc/mdidentd-1.04c
	ssl? ( dev-libs/openssl )
	boost? ( dev-libs/boost )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch #251445
}

src_compile() {
	econf \
		$(use_with ssl) \
		$(use_with boost) \
		|| die
	emake CXX_OPTIMIZATIONS="${CXXFLAGS}" || die
}

src_install() {
	dobin ezbounce || die
	dosym ezbounce /usr/bin/ezb
	dodoc CHANGES TODO README ezb.conf sample.*
	doman misc/ezbounce.1
}
