# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/vblade/vblade-6.ebuild,v 1.1 2005/09/16 06:12:11 robbat2 Exp $

DESCRIPTION="vblade exports a block device using AoE"
HOMEPAGE="http://sf.net/projects/aoetools/"
SRC_URI="mirror://sourceforge/aoetools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc"
RDEPEND="${DEPEND}
		sys-apps/util-linux"

src_unpack() {
	unpack ${A}
	cd ${S}
	# messy tarball
	make clean  || die "Failed to clean up source"
	sed -i 's,^CFLAGS.*,CFLAGS += -Wall,' makefile || die "Failed to clean up makefile"
}
src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /usr
	doman vblade.8
	dodoc HACKING NEWS README vbladed
	dosbin vblade
}

pkg_postinst() {
	einfo "TODO: write a Gentoo init.d script for vblade"
}
