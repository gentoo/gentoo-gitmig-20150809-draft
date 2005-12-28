# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ezbounce/ezbounce-1.04a.ebuild,v 1.8 2005/12/28 21:01:45 vapier Exp $

inherit eutils

DESCRIPTION="ezbounce is a small IRC bouncer"
HOMEPAGE="http://druglord.freelsd.org/ezbounce/"
SRC_URI="http://druglord.freelsd.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"

DEPEND=">=net-misc/mdidentd-1.04a
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-crash-fix.patch
	epatch "${FILESDIR}"/${P}-c++.patch
}

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
