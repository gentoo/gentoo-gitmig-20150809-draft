# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/aoetools/aoetools-24.ebuild,v 1.3 2008/05/12 16:09:43 corsair Exp $

DESCRIPTION="aoetools are programs for users of the ATA over Ethernet (AoE) network storage protocol"
HOMEPAGE="http://sf.net/projects/aoetools/"
SRC_URI="mirror://sourceforge/aoetools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 ~x86"
IUSE=""
DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	sys-apps/util-linux"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's,^CFLAGS.*,CFLAGS += -Wall,g' \
		Makefile || die "Failed to clean up makefile"
}
src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc NEWS README TODO
}
