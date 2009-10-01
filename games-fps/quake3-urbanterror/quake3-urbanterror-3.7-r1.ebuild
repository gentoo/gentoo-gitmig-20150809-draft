# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-urbanterror/quake3-urbanterror-3.7-r1.ebuild,v 1.6 2009/10/01 21:49:38 nyhm Exp $

MOD_DESC="total transformation realism based MOD"
MOD_NAME="Urban Terror"
MOD_DIR="q3ut3"
MOD_BINS="ut3"

inherit games games-mods

HOMEPAGE="http://www.urbanterror.net/"
SRC_URI="http://urt.utca.hu/files/urbanterror/official/urbanTerror37_full.zip"

LICENSE="freedist"
SLOT="3"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
RESTRICT="mirror strip"
