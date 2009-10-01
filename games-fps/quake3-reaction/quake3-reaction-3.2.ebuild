# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-reaction/quake3-reaction-3.2.ebuild,v 1.3 2009/10/01 21:46:24 nyhm Exp $

MOD_DESC="port of Action Quake 2 to Quake 3: Arena"
MOD_NAME="Reaction"
MOD_DIR="reaction"

inherit games games-mods

HOMEPAGE="http://www.rq3.com/"
SRC_URI="http://www.rq3.com/ReactionQuake3-v${PV}-Full.zip
	http://ftp.stu.edu.tw/FreeBSD/distfiles/ReactionQuake3-v${PV}-Full.zip
	http://ftp.twaren.net/BSD/FreeBSD/distfiles/ReactionQuake3-v${PV}-Full.zip
	http://ftp.giga.net.tw/OS/FreeBSD/distfiles/ReactionQuake3-v${PV}-Full.zip"

LICENSE="as-is"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
