# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/khexclock/khexclock-0.1.5.ebuild,v 1.1 2005/07/27 17:23:36 smithj Exp $

inherit kde

IUSE=""
DESCRIPTION="KHexClock shows the current hexadecimal time and date."
HOMEPAGE="http://utopios.org/~luke-jr/programs/khexclock/"
SRC_URI="http://utopios.org/~luke-jr/programs/${PN}/${P}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

need-kde 3
