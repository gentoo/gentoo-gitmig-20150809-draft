# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arc/arc-5.21j.ebuild,v 1.3 2004/03/31 13:12:17 aliz Exp $

DESCRIPTION="Create & extract files from DOS .ARC files."
SRC_URI="mirror://sourceforge/arc/${P}.tar.gz"
HOMEPAGE="http://arc.sourceforge.net/"

KEYWORDS="x86 ~alpha ~amd64 sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

S=${WORKDIR}/${P}

src_compile() {
	emake CC=${CC} OPT="${CFLAGS}" || die
}

src_install() {
	into /usr
	dobin arc marc
	doman arc.1
}
