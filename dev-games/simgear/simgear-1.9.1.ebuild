# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/simgear/simgear-1.9.1.ebuild,v 1.7 2011/02/26 13:31:55 armin76 Exp $
EAPI=2

inherit eutils

MY_P="SimGear-${PV/_/-}"
DESCRIPTION="Development library for simulation games"
HOMEPAGE="http://www.simgear.org/"
SRC_URI="mirror://simgear/Source/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=media-libs/plib-1.8.5
	dev-games/openscenegraph
	>=dev-libs/boost-1.34.0
	media-libs/openal
	media-libs/freealut"
DEPEND="${RDEPEND}"

RESTRICT="test"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc NEWS AUTHORS TODO
}
