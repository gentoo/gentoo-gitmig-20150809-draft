# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/deutex/deutex-4.4.0.ebuild,v 1.8 2011/01/12 22:49:31 mr_bones_ Exp $

EAPI=2
inherit base toolchain-funcs

DESCRIPTION="A wad composer for Doom, Heretic, Hexen and Strife"
HOMEPAGE="http://www.teaser.fr/~amajorel/deutex/"
SRC_URI="http://www.teaser.fr/~amajorel/deutex/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2 as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=""
DEPEND=""

PATCHES=( "${FILESDIR}"/${P}-makefile.patch "${FILESDIR}"/${P}-64bit.patch
	"${FILESDIR}"/${P}-ovflfix.patch )

src_compile() {
	tc-export CC
	base_src_make
}

src_install() {
	dobin deusf deutex || die
	doman deutex.6
	dodoc CHANGES README TODO
}
