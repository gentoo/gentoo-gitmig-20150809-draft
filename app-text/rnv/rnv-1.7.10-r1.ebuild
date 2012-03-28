# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rnv/rnv-1.7.10-r1.ebuild,v 1.2 2012/03/28 06:57:43 ago Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A lightweight Relax NG Compact Syntax validator"
HOMEPAGE="http://www.davidashen.net/rnv.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/expat"
DEPEND="${RDEPEND}
		app-arch/unzip"

src_install() {
	dobin rnv rvp arx
	dodoc readme.txt
}
