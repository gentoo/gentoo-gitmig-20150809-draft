# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/cpio/cpio-2.5.ebuild,v 1.11 2004/12/06 05:19:50 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="A file archival tool which can also read and write tar files"
HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"
SRC_URI="mirror://gnu/cpio/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ~ppc-macos s390 sh sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "78d" rmt.c
}

src_install() {
	#our official mt is now the mt in app-arch/mt-st (supports Linux 2.4, unlike this one)
	doman cpio.1
	dodoc ChangeLog NEWS README INSTALL
	into /
	dobin cpio || die
}
