# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmuddy/kmuddy-0.7.1.ebuild,v 1.1 2005/04/05 00:46:36 mr_bones_ Exp $

inherit kde

DESCRIPTION="MUD client for KDE"
HOMEPAGE="http://www.kmuddy.net"
SRC_URI="http://www.kmuddy.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="kde-base/arts"
need-kde 3
