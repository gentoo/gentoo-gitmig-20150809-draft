# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/stratego/stratego-0.7.ebuild,v 1.3 2002/07/23 05:02:15 george Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Stratego term-rewriting language"
SRC_URI="http://www.stratego-language.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.stratego-language.org"

DEPEND=">=dev-libs/aterm-1.6.6
	>=dev-libs/cpl-stratego-0.4"
RDEPEND="$DEPEND"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	make DESTDIR=${D} install || die
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
}
