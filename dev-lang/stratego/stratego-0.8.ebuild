# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/stratego/stratego-0.8.ebuild,v 1.8 2003/08/05 18:57:11 vapier Exp $

DESCRIPTION="Stratego term-rewriting language"
HOMEPAGE="http://www.stratego-language.org/"
SRC_URI="http://www.stratego-language.org/ftp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=">=dev-libs/aterm-1.6.7
	>=dev-libs/cpl-stratego-0.4"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make DESTDIR=${D} || die
}

src_install() {
	make DESTDIR=${D} install || die
}
