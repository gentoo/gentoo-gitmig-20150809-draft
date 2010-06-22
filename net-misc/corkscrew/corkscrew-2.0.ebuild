# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/corkscrew/corkscrew-2.0.ebuild,v 1.9 2010/06/22 17:41:00 angelos Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Corkscrew is a tool for tunneling SSH through HTTP proxies."
HOMEPAGE="http://www.agroman.net/corkscrew/"
LICENSE="GPL-2"
DEPEND=""
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
SLOT="0"
SRC_URI="http://www.agroman.net/corkscrew/${P}.tar.gz"

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO || die "dodoc failed"
}
