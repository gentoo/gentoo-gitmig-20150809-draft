# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kdsl/kdsl-0.5.ebuild,v 1.1 2004/11/15 19:39:40 mrness Exp $

inherit flag-o-matic kde

DESCRIPTION="Frontend for pppd with DSL support for PPPoE/PPPoA connections"
HOMEPAGE="http://kdslbroadband.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdslbroadband/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="net-dialup/ppp"

need-kde 3

src_compile() {
	append-ldflags -Wl,-z,now
	kde_src_compile
}
