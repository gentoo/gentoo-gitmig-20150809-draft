# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arc/arc-5.21j.ebuild,v 1.14 2005/05/17 22:04:30 ticho Exp $

inherit toolchain-funcs

DESCRIPTION="Create & extract files from DOS .ARC files."
HOMEPAGE="http://arc.sourceforge.net/"
SRC_URI="mirror://sourceforge/arc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake CC="$(tc-getCC)" OPT="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin arc marc || die "dobin failed"
	doman arc.1
}
