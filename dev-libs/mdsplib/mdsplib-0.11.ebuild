# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mdsplib/mdsplib-0.11.ebuild,v 1.5 2009/01/03 14:14:36 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="METAR Decoder Software Package Library"
HOMEPAGE="http://limulus.net/mdsplib/"
SRC_URI="http://limulus.net/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" all || die "make failed"
}

src_install() {
	insinto /usr/include
	insopts -m0644
	newins metar.h metar.h
	dolib.a libmetar.a
	dodoc README README.MDSP
	dobin dmetar || die
}
