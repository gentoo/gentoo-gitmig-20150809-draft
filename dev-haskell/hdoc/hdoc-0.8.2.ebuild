# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdoc/hdoc-0.8.2.ebuild,v 1.1 2003/04/22 08:26:25 kosmikus Exp $

DESCRIPTION="A documentation generator for Haskell"

HOMEPAGE="http://www.fmi.uni-passau.de/~groessli/hdoc/"

LICENSE="GPL-2"

IUSE="nhc98"
SLOT="0"
KEYWORDS="~x86"

DEPEND="!nhc98? ( virtual/ghc )
	nhc98?  ( dev-lang/nhc98
		dev-haskell/hmake )"
RDEPEND="virtual/glibc"

SRC_URI="http://www.fmi.uni-passau.de/~groessli/hdoc/${P}.tar.gz"

src_compile() {
	if [ "`use nhc98`" ] ; then
		buildwith="--with-compiler=nhc98"
		# I don't see why nhc98 complains in the presence of this
		# file, but I am certain that it does no harm to remove it ...
		rm hsparser/HsParser.ly
	else
		buildwith="--with-compiler=ghc"
	fi
	econf ${buildwith} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	# DESTDIR does not work, but only bindir is used ...
	make bindir=${D}/usr/bin install || die
	dodoc docs/hdoc.pdf 
}
