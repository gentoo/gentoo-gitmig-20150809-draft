# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Sascha Schwabbauer <cybersystem@gentoo.org>

inherit kde-base || die

need-kde 3

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"

S="${WORKDIR}/${P}"
DESCRIPTION="Napster Client for Linux"
SRC_URI="mirror://sourceforge/knapster/${P}.tar.gz"
HOMEPAGE="http://knapster.sourceforge.net"

src_unpack() {
        cd ${WORKDIR}
        unpack ${A}
        cd ${S}
        patch -p1 < ${FILESDIR}/${P}-gcc3.2.diff || die
}
