# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/slune/slune-0.3.1.ebuild,v 1.2 2004/02/20 06:13:57 mr_bones_ Exp $

inherit distutils

DESCRIPTION="A 3D action game with multiplayer mode and amazing graphics"
SRC_URI="http://www.nectroom.homelinux.net/pkg/Slune-${PV}.tar.bz2"
HOMEPAGE="http://oomadness.tuxfamily.org/en/slune/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/opengl
	>=dev-lang/python-2.2.2
	>=dev-python/soya-0.3.1
	>=dev-python/py2play-0.1.2
	>=dev-python/pyopenal-0.1.1
	>=dev-python/editobj-0.3.1"

S=${WORKDIR}/Slune-${PV}
