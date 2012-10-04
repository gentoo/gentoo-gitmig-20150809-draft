# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/odhcploc/odhcploc-20111021.ebuild,v 1.1 2012/10/04 03:22:54 jer Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Open DHCP Locator"
HOMEPAGE="http://odhcploc.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${PV}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

src_prepare() {
	tc-export CC
}

src_install() {
	dobin ${PN}
	doman ${PN}.8
	dodoc AUTHORS
}
