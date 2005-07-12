# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-strikeforce/ut2004-strikeforce-3.01.ebuild,v 1.1 2005/07/12 19:56:09 wolf31o2 Exp $

MOD_DESC="A Terrorist vs. Strike Force mod for UT2004"
MOD_NAME="Strike Force"
MOD_BINS=strikeforce
MOD_TBZ2=strike.force
MOD_ICON=strike.force.xpm
inherit games games-ut2k4mod

HOMEPAGE="http://www.strikeforce2004.com/"
SRC_URI="strike.force_${PV}-english.run"

LICENSE="freedist"
IUSE=""
