# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/skyutils/skyutils-2.1.ebuild,v 1.3 2002/12/09 04:21:04 manson Exp $

IUSE=""

DESCRIPTION="Library of assorted C utility functions."
HOMEPAGE="http://zekiller.skytech.org/coders_en.html"
SRC_URI="http://zekiller.skytech.org/fichiers/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc "

DEPEND="virtual/glibc"

S="${WORKDIR}/skyutils"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
