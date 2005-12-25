# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kdsl/kdsl-0.5.ebuild,v 1.3 2005/12/25 15:10:04 flameeyes Exp $

inherit flag-o-matic kde

DESCRIPTION="Frontend for pppd with DSL support for PPPoE/PPPoA connections"
HOMEPAGE="http://kdslbroadband.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdslbroadband/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="net-dialup/ppp"

need-kde 3

src_compile() {
	append-ldflags $(bindnow-flags)
	kde_src_compile
}
