# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rnv/rnv-1.7.8-r1.ebuild,v 1.2 2008/05/24 14:15:40 maekke Exp $

DESCRIPTION="A lightweight Relax NG Compact Syntax validator"
HOMEPAGE="http://www.davidashen.net/rnv.html"
SRC_URI="http://ftp.davidashen.net/PreTI/RNV/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}
		app-arch/unzip"

src_compile() {
	emake -j1 -f Makefile.gnu || die
}

src_install() {
	dobin rnv rvp arx
	dodoc readme.txt
}
