# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cksfv/cksfv-1.3.ebuild,v 1.12 2004/05/28 15:40:59 vapier Exp $

inherit eutils

DESCRIPTION="SFV checksum utility (simple file verification)"
HOMEPAGE="http://www.fodder.org/cksfv/"
SRC_URI="http://www.fodder.org/cksfv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~amd64"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	# patch for int size problems on 64bit systems
	use amd64 && epatch ${FILESDIR}/${P}-64bit-fix.patch
	emake || die
}

src_install() {
	dobin src/cksfv || die
	dodoc ChangeLog INSTALL README TODO
}
