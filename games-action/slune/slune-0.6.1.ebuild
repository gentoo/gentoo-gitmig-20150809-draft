# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/slune/slune-0.6.1.ebuild,v 1.1 2003/12/21 16:38:27 kloeri Exp $

inherit distutils

DESCRIPTION="A 3D action game with multiplayer mode and amazing graphics"
SRC_URI="http://oomadness.tuxfamily.org/downloads/Slune-${PV}.tar.bz2"
HOMEPAGE="http://oomadness.tuxfamily.org/en/slune/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.6
	>=dev-lang/python-2.2.2
	>=dev-python/soya-0.6.1
	>=dev-python/py2play-0.1.6
	>=dev-python/pyopenal-0.1.3
	>=dev-python/editobj-0.5.3"

S=${WORKDIR}/Slune-${PV}
