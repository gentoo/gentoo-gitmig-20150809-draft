# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arc/arc-5.21j.ebuild,v 1.2 2004/02/27 01:58:15 bazik Exp $

DESCRIPTION="Create & extract files from DOS .ARC files."
SRC_URI="mirror://sourceforge/arc/${P}.tar.gz"
HOMEPAGE="http://arc.sourceforge.net/"

KEYWORDS="x86 ~alpha ~amd64 sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

S=${WORKDIR}/${P}

src_compile() {
	emake OPT="${CFLAGS}" || die
}

src_install() {
	into /usr
	dobin arc marc
	doman arc.1
}
