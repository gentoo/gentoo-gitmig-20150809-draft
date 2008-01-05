# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/bashmark/bashmark-0.6.2.ebuild,v 1.3 2008/01/05 13:43:46 maekke Exp $

inherit eutils

DESCRIPTION="Geno's cross platform benchmarking suite"
HOMEPAGE="http://bashmark.coders-net.de"

SRC_URI="http://bashmark.coders-net.de/download/src/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/bashmark-0.6.2-as-needed.patch
}

src_install() {
	dobin bashmark
	dodoc ChangeLog
}
