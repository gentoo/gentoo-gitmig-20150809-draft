# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/slune/slune-1.0.11.ebuild,v 1.1 2006/04/23 01:47:58 mr_bones_ Exp $

inherit distutils

DESCRIPTION="A 3D action game with multiplayer mode and amazing graphics"
HOMEPAGE="http://oomadness.tuxfamily.org/en/slune/"
SRC_URI="http://download.gna.org/slune/Slune-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.6
	>=dev-lang/python-2.2.2
	>=dev-python/soya-0.9
	>=dev-python/py2play-0.1.6
	>=dev-python/pyopenal-0.1.3
	>=dev-python/pyogg-1.1
	>=dev-python/pyvorbis-1.1"

S=${WORKDIR}/Slune-${PV}
