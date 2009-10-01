# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-lrctf/quake3-lrctf-1.1.ebuild,v 1.3 2009/10/01 21:32:07 nyhm Exp $

MOD_DESC="offhand grapple all-weapons capture the flag mod"
MOD_NAME="Loki's Revenge CTF"
MOD_DIR="lrctf"

GAMES_CHECK_LICENSE="yes"

inherit games games-mods

HOMEPAGE="http://www.lrctf.com/"
SRC_URI="http://lrctf.com/release/LRCTF_Q3A_v1.1_full.zip"

LICENSE="LRCTF"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
PROPERTIES="interactive"
