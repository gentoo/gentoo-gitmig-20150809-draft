# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/khexclock/khexclock-0.0.4.ebuild,v 1.6 2005/05/01 20:14:19 carlo Exp $

inherit kde

IUSE=""
DESCRIPTION="KHexClock shows the current hexadecimal time and date."
HOMEPAGE=""
SRC_URI="http://mystery.ryalth.com/~luke-jr/programs/khexclock/${P}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"

need-kde 3