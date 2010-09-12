# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pe-format/pe-format-2.0.3.ebuild,v 1.2 2010/09/12 17:50:33 pacho Exp $

inherit toolchain-funcs

DESCRIPTION="Intelligent PE executable wrapper for binfmt_misc"
HOMEPAGE="http://github.com/mgorny/pe-format2/"
SRC_URI="http://github.com/downloads/mgorny/${PN}2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="!sys-apps/pe-format2"

src_compile() {
	tc-export CC
	emake || die
}

src_install() {
	emake ginstall || die
}
