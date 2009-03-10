# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/aoetools/aoetools-29.ebuild,v 1.2 2009/03/10 17:05:40 mr_bones_ Exp $

DESCRIPTION="aoetools are programs for users of the ATA over Ethernet (AoE) network storage protocol"
HOMEPAGE="http://sf.net/projects/aoetools/"
SRC_URI="mirror://sourceforge/aoetools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="${DEPEND}
	sys-apps/util-linux"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's,^CFLAGS.*,CFLAGS += -Wall,g' Makefile || die "Failed to clean up makefile"
}
