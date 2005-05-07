# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/slune/slune-0.6.1.ebuild,v 1.9 2005/05/07 23:40:16 vapier Exp $

inherit distutils

DESCRIPTION="A 3D action game with multiplayer mode and amazing graphics"
HOMEPAGE="http://oomadness.tuxfamily.org/en/slune/"
SRC_URI="http://oomadness.nekeme.net/downloads/Slune-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.6
	>=dev-lang/python-2.2.2
	>=dev-python/soya-0.6.1
	>=dev-python/py2play-0.1.6
	>=dev-python/pyopenal-0.1.3
	>=dev-python/editobj-0.5.3"

S="${WORKDIR}/Slune-${PV}"
