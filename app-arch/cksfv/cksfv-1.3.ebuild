# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cksfv/cksfv-1.3.ebuild,v 1.11 2004/05/25 20:41:22 jhuebel Exp $

DESCRIPTION="cksfv: SFV checksum utility (simple file verification)"
SRC_URI="http://www.fodder.org/cksfv/${P}.tar.gz"
HOMEPAGE="http://www.fodder.org/cksfv/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~amd64"

DEPEND="virtual/glibc"

src_compile() {
	# patch for int size problems on 64bit systems
	use amd64 && epatch ${FILESDIR}/${P}-64bit-fix.patch

	emake || die
}

src_install() {
	dobin src/cksfv
	dodoc COPYING ChangeLog INSTALL README TODO
}
