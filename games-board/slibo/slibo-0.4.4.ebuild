# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/slibo/slibo-0.4.4.ebuild,v 1.1 2003/09/12 00:52:57 vapier Exp $

inherit kde

need-kde 3

DESCRIPTION="A comfortable replacement for the xboard chess interface"
SRC_URI="mirror://sourceforge/slibo/${P}.tar.bz2"
HOMEPAGE="http://slibo.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="dev-db/sqlite"
