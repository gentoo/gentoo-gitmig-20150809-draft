# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/disktype/disktype-7.ebuild,v 1.1 2005/03/05 22:43:21 ciaranm Exp $

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
	make CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin disktype
	dodoc README HISTORY LICENSE TODO
}
