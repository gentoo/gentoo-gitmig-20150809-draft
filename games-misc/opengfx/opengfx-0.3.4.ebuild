# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/opengfx/opengfx-0.3.4.ebuild,v 1.1 2011/07/16 22:10:30 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="OpenGFX data files for OpenTTD"
HOMEPAGE="http://bundles.openttdcoop.org/opengfx/"
SRC_URI="http://bundles.openttdcoop.org/opengfx/releases/${PV}/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE=""

S=${WORKDIR}/${P}-source

DEPEND=">=games-util/grfcodec-5.1.1"
RDEPEND=""

src_compile() {
	emake bundle || die
}

src_install() {
	insinto "${GAMES_DATADIR}/openttd/data/"
	doins *.grf opengfx.obg || die
	dodoc docs/{changelog.txt,readme.txt} || die
	prepgamesdirs
}
