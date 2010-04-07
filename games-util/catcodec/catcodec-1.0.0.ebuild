# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/catcodec/catcodec-1.0.0.ebuild,v 1.2 2010/04/07 17:27:22 mr_bones_ Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Decodes and encodes sample catalogues for OpenTTD"
HOMEPAGE="http://www.openttd.org/en/download-catcodec"
SRC_URI="http://binaries.openttd.org/extra/catcodec/${PV}/${P}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	tc-export CXX
}

src_install() {
	dobin catcodec || die
	dodoc README || die
	doman catcodec.1 || die
}
