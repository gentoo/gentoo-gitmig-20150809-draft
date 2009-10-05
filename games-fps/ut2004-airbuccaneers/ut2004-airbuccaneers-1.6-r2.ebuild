# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-airbuccaneers/ut2004-airbuccaneers-1.6-r2.ebuild,v 1.1 2009/10/05 23:21:01 nyhm Exp $

EAPI=2

MOD_DESC="Pirate-style conversion with flying wooden ships"
MOD_NAME="Air Buccaneers"
MOD_DIR="AirBuccaneers"
MOD_ICON="Help/abuicon.ico"

inherit games games-mods

HOMEPAGE="http://ludocraft.oulu.fi/airbuccaneers/"
SRC_URI="http://ludocraft.oulu.fi/airbuccaneers/download/airbuccaneers1_6_zipinstall.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated opengl"
