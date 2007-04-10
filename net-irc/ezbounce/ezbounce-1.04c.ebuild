# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ezbounce/ezbounce-1.04c.ebuild,v 1.1 2007/04/10 14:11:40 armin76 Exp $

inherit eutils

DESCRIPTION="ezbounce is a small IRC bouncer"
HOMEPAGE="http://druglord.freelsd.org/ezbounce/"
SRC_URI="http://druglord.freelsd.org/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"

DEPEND=">=net-misc/mdidentd-1.04c
	ssl? ( dev-libs/openssl )"

src_compile() {
	econf $(use_with ssl) || die
	emake CXX_OPTIMIZATIONS="${CXXFLAGS}" || die
}

src_install() {
	dobin ezbounce || die
	dosym ezbounce /usr/bin/ezb
	dodoc CHANGES TODO README ezb.conf sample.*
	doman misc/ezbounce.1
}
