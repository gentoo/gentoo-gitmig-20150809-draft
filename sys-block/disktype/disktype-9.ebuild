# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/disktype/disktype-9.ebuild,v 1.8 2007/06/10 01:10:45 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="Detect the content format of a disk or disk image."
HOMEPAGE="http://disktype.sourceforge.net/"
SRC_URI="mirror://sourceforge/disktype/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

IUSE=""
DEPEND="virtual/libc"

src_compile() {
	make CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin disktype
	dodoc README HISTORY TODO
	doman disktype.1
}
