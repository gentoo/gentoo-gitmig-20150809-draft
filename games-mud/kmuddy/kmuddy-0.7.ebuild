# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmuddy/kmuddy-0.7.ebuild,v 1.4 2005/03/12 22:44:59 mr_bones_ Exp $

inherit kde

DESCRIPTION="MUD client for KDE"
HOMEPAGE="http://www.kmuddy.org"
SRC_URI="http://www.kmuddy.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="kde-base/arts"
need-kde 3
