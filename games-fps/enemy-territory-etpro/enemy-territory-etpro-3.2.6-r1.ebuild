# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-etpro/enemy-territory-etpro-3.2.6-r1.ebuild,v 1.4 2009/10/08 01:50:13 nyhm Exp $

EAPI=2

GAME="enemy-territory"
MOD_DESC="a series of minor additions to Enemy Territory to make it more fun"
MOD_NAME="ETPro"
MOD_DIR="etpro"

inherit games games-mods

HOMEPAGE="http://bani.anime.net/etpro/"
SRC_URI="http://etpro.anime.net/etpro-${PV//./_}.zip"

LICENSE="as-is"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"
