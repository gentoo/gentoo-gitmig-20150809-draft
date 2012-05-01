# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/premake/premake-3.5.ebuild,v 1.4 2012/05/01 17:10:01 ago Exp $

EAPI=4

DESCRIPTION="A makefile generation tool"
HOMEPAGE="http://premake.berlios.de/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${P/p/P}

src_install() {
	dobin bin/${PN}
}
