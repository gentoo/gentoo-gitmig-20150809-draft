# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/skyutils/skyutils-2.1.ebuild,v 1.2 2002/11/28 04:36:52 george Exp $

IUSE=""

DESCRIPTION="Library of assorted C utility functions."
HOMEPAGE="http://zekiller.skytech.org/coders_en.html"
SRC_URI="http://zekiller.skytech.org/fichiers/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~sparc64"

DEPEND="virtual/glibc"

S="${WORKDIR}/skyutils"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
