# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-alienswarm/ut2004-alienswarm-1.2.ebuild,v 1.2 2004/11/29 15:33:44 wolf31o2 Exp $

MOD_DESC="Alien Swarm is an overhead view tactical squad-based shooter"
MOD_NAME="Alien Swarm"
MOD_BINS=alienswarm
MOD_TBZ2=${MOD_BINS}
MOD_ICON=${MOD_BINS}.xpm
inherit games games-ut2k4mod

HOMEPAGE="http://www.blackcatgames.com/swarm/"
SRC_URI="alien.swarm_${PV}-english.run"

LICENSE="freedist"
IUSE=""
