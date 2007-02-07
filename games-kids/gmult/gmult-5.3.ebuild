# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-kids/gmult/gmult-5.3.ebuild,v 1.1 2007/02/07 14:50:15 nyhm Exp $

inherit gnome2

DESCRIPTION="Multiplication Puzzle is a simple GTK+ 2 game that emulates the multiplication game found in Emacs."
HOMEPAGE="http://www.mterry.name/gmult/"
SRC_URI="http://www.mterry.name/gmult/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-cpp/gtkmm-2.6"
