# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/slibo/slibo-0.4.4.ebuild,v 1.5 2004/06/24 22:21:39 agriffis Exp $

inherit kde
need-kde 3

DESCRIPTION="A comfortable replacement for the xboard chess interface"
HOMEPAGE="http://slibo.sourceforge.net/"
SRC_URI="mirror://sourceforge/slibo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-db/sqlite"
