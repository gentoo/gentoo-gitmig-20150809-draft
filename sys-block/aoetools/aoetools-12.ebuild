# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/aoetools/aoetools-12.ebuild,v 1.4 2007/12/16 09:52:24 drac Exp $

DESCRIPTION="aoetools are programs for users of the ATA over Ethernet (AoE) network storage protocol"
HOMEPAGE="http://sf.net/projects/aoetools/"
SRC_URI="mirror://sourceforge/aoetools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""
DEPEND="virtual/libc"
RDEPEND="${DEPEND}
		sys-apps/util-linux"

src_unpack() {
	unpack ${A}
	cd ${S}
	# messy tarball
	make clean  || die "Failed to clean up source"
	sed -i \
		-e '/mkdir/s, \(${.*}\), ${DESTDIR}\1,g' \
		-e 's,^CFLAGS.*,CFLAGS += -Wall,g' \
		Makefile || die "Failed to clean up makefile"
	for i in aoe-stat aoe-mkshelf.in ; do
		sed -i \
			-e '/bc/s!\\\*!*!g' \
			-e '/bc/s!"!!g' \
			-e '/bc/s!=`echo \(.*\) | bc`!=$((\1))!g' \
			${i}
	done
}
src_compile() {
	emake || die "emake failed"
}

src_install() {
	into /usr
	emake -j1 install DESTDIR="${D}" SBINDIR="/usr/sbin" MANDIR="/usr/share/man"
	dodoc HACKING NEWS README TODO devnodes.txt
}
