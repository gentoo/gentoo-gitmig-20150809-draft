# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/disktype/disktype-7.ebuild,v 1.1 2004/12/19 00:24:55 dragonheart Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Detect the content format of a disk or disk image."
HOMEPAGE="http://disktype.sourceforge.net/"
SRC_URI="mirror://sourceforge/disktype/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

IUSE=""
DEPEND="virtual/libc"

src_compile() {
	make CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin disktype
	dodoc README HISTORY LICENSE TODO
}
