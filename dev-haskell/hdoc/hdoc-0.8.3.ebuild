# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdoc/hdoc-0.8.3.ebuild,v 1.1 2004/10/21 16:04:32 kosmikus Exp $

DESCRIPTION="A documentation generator for Haskell"

HOMEPAGE="http://www.fmi.uni-passau.de/~groessli/hdoc/"

LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/ghc"
RDEPEND="virtual/libc"

SRC_URI="http://www.fmi.uni-passau.de/~groessli/hdoc/${P}.tar.gz"

src_compile() {
	econf --with-compiler=ghc || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	# DESTDIR does not work, but only bindir is used ...
	make bindir=${D}/usr/bin install || die "installation failed"
	dodoc docs/hdoc.pdf
}
