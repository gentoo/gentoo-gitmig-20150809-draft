# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/aclock/aclock-0.2.ebuild,v 1.2 2004/10/14 19:59:41 dholm Exp $

inherit gnustep

DESCRIPTION="A clock!"
HOMEPAGE="http://www.linuks.mine.nu/aclock/"
SRC_URI="http://www.linuks.mine.nu/aclock/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="${IUSE}"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

