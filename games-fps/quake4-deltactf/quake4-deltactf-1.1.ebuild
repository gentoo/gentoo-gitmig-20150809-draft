# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake4-deltactf/quake4-deltactf-1.1.ebuild,v 1.1 2007/09/15 19:07:46 wolf31o2 Exp $

MOD_DESC="Delta Capture-The-Flag"
MOD_NAME="Delta CTF"
MOD_DIR="deltactf"
MOD_ICON="deltactf.xpm"

inherit games games-mods

# Ensure it's quake4 rather than q4, until eclass is fixed
GAME_EXE="quake4"
DED_EXE="quake4-ded"

TURKEY="http://turkeyfiles.escapedturkey.net/quake4/deltactf"
ACM="http://acmectf.com/downloads/Quake4/Mods"

# deltactf.com seems dead, but should be the homepage
HOMEPAGE="http://quake4.filefront.com/file/DeltaCTF_11_Patch;72609
	http://www.deltactf.com"
# Weird extra zeros in filenames
SRC_URI="${TURKEY}/DeltaCTF_1.000.zip
	${ACM}/DeltaCTF_1.000.zip
	${TURKEY}/DeltaCTF_1.100_Patch.zip
	${ACM}/DeltaCTF_1.100_Patch.zip"

LICENSE="as-is"

RDEPEND="games-fps/quake4-bin"
