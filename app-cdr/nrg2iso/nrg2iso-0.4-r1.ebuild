# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/nrg2iso/nrg2iso-0.4-r1.ebuild,v 1.2 2004/12/25 16:00:54 ticho Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Converts Nero nrg CD-images to iso"
HOMEPAGE="http://gregory.kokanosky.free.fr/v4/linux/nrg2iso.en.html"
SRC_URI="http://gregory.kokanosky.free.fr/v4/linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	$(tc-getCC) ${CFLAGS} -o nrg2iso nrg2iso.c || die "failed to compile"
}

src_install() {
	dobin nrg2iso || die
	dodoc CHANGELOG || die
}
