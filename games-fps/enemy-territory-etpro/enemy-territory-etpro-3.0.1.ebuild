# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-etpro/enemy-territory-etpro-3.0.1.ebuild,v 1.1 2005/01/15 21:14:19 vapier Exp $

MOD_DESC="ETPro"
MOD_NAME=etpro
inherit games games-etmod

MY_PV=${PV//./_}
HOMEPAGE="http://bani.anime.net/etpro/"
SRC_URI="http://bani.anime.net/etpro/etpro-${MY_PV}.zip"

LICENSE="as-is"
