# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake4-deltactf/quake4-deltactf-1.1.ebuild,v 1.3 2009/10/08 04:00:22 nyhm Exp $

EAPI=2

MOD_DESC="Delta Capture-The-Flag"
MOD_NAME="Delta CTF"
MOD_DIR="deltactf"
MOD_ICON="deltactf.xpm"

inherit games games-mods

HOMEPAGE="http://quake4.filefront.com/file/DeltaCTF_11_Patch;72609"
SRC_URI="mirror://quakeunity/quake4/modifications/deltactf/DeltaCTF_1.000.zip
	mirror://quakeunity/quake4/modifications/deltactf/DeltaCTF_1.100_Patch.zip"

LICENSE="freedist"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"
