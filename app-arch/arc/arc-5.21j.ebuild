# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arc/arc-5.21j.ebuild,v 1.4 2004/04/10 07:15:25 mr_bones_ Exp $

DESCRIPTION="Create & extract files from DOS .ARC files."
HOMEPAGE="http://arc.sourceforge.net/"
SRC_URI="mirror://sourceforge/arc/${P}.tar.gz"

KEYWORDS="x86 ~alpha ~amd64 sparc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake CC=${CC} OPT="${CFLAGS}" || die "emake failed"
}

src_install() {
	into /usr
	dobin arc marc || die "dobin failed"
	doman arc.1
}
