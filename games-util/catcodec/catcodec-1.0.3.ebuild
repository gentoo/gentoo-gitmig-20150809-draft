# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/catcodec/catcodec-1.0.3.ebuild,v 1.2 2011/07/16 19:36:37 hwoarang Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Decodes and encodes sample catalogues for OpenTTD"
HOMEPAGE="http://www.openttd.org/en/download-catcodec"
SRC_URI="http://binaries.openttd.org/extra/catcodec/${PV}/${P}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""

src_prepare() {
	tc-export CXX
}

src_compile() {
	emake VERBOSE=1 || die
}

src_install() {
	dobin catcodec || die
	dodoc changelog.txt docs/readme.txt
	doman docs/catcodec.1
}
