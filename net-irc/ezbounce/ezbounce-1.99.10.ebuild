# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ezbounce/ezbounce-1.99.10.ebuild,v 1.1 2008/02/04 11:03:17 cla Exp $

inherit eutils

DESCRIPTION="ezbounce is a small IRC bouncer"
HOMEPAGE="http://www.linuxftw.com/ezbounce/"
SRC_URI="http://www.linuxftw.com/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl boost"

DEPEND=">=net-misc/mdidentd-1.04c
	ssl? ( dev-libs/openssl )
	boost? ( dev-libs/boost )"

src_compile() {
	econf $(use_with ssl) \
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
