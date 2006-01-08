# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/disktype/disktype-8.ebuild,v 1.2 2006/01/08 04:22:57 dragonheart Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Detect the content format of a disk or disk image."
HOMEPAGE="http://disktype.sourceforge.net/"
SRC_URI="mirror://sourceforge/disktype/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc"

IUSE=""
DEPEND="virtual/libc"

src_compile() {
	make CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin disktype
	dodoc README HISTORY TODO
}
