# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/stratego/stratego-0.8.ebuild,v 1.7 2003/07/11 22:14:08 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Stratego term-rewriting language"
SRC_URI="http://www.stratego-language.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.stratego-language.org"
DEPEND=">=dev-libs/aterm-1.6.7
	>=dev-libs/cpl-stratego-0.4"
RDEPEND="$DEPEND"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make DESTDIR=${D} || die
}

src_install () {
	make DESTDIR=${D} install || die
}
