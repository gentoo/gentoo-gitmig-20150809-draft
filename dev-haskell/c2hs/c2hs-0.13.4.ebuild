# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/c2hs/c2hs-0.13.4.ebuild,v 1.1 2004/11/17 13:35:24 kosmikus Exp $

inherit ghc-package

DESCRIPTION="An interface generator for Haskell"
HOMEPAGE="http://www.cse.unsw.edu.au/~chak/haskell/c2hs/"
SRC_URI="http://www.cse.unsw.edu.au/~chak/haskell/c2hs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND=">=virtual/ghc-6.0"

src_unpack() {
	unpack ${A}
	# don't add ghc version to libdir
	sed -i 's:-$(PCKVERSION)/$(SYS)::' ${S}/mk/config.mk.in \
		|| die "config.mk.in patch didn't apply"
	sed -i 's:-@C2HS_VERSION@/@SYS@::' ${S}/c2hs/c2hs.conf.in \
		|| die "c2hs.conf.in patch didn't apply"
}

src_compile() {
	econf \
		--disable-add-package \
		--libdir=$(ghc-libdir) \
		|| die "configure failed"

	# tested -j2; doesn't work
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	cp ${D}/$(ghc-libdir)/c2hs/c2hs.conf ${S}/$(ghc-localpkgconf)
	ghc-makeghcilib ${D}/$(ghc-libdir)/c2hs/libc2hs.a
	ghc-install-pkg
}

