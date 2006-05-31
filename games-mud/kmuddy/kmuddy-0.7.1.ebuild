# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmuddy/kmuddy-0.7.1.ebuild,v 1.2 2006/05/31 15:56:14 flameeyes Exp $

ARTS_REQUIRED="yes"
inherit kde

DESCRIPTION="MUD client for KDE"
HOMEPAGE="http://www.kmuddy.net"
SRC_URI="http://www.kmuddy.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

need-kde 3
