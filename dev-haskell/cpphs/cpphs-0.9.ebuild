# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cpphs/cpphs-0.9.ebuild,v 1.4 2006/10/11 18:38:06 dcoutts Exp $

inherit eutils ghc-package

DESCRIPTION="A liberalised cpp-a-like preprocessor for Haskell"
HOMEPAGE="http://www.cs.york.ac.uk/fp/cpphs/"
SRC_URI="http://www.cs.york.ac.uk/fp/cpphs/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""
DEPEND=">=virtual/ghc-5.04"

src_compile() {
	$(ghc-getghc) --make -O cpphs.hs -o cpphs \
		|| die "ghc --make failed"
}

src_install() {
	dobin ${S}/cpphs
	dodoc README CHANGELOG
	doman docs/cpphs.1
	dohtml docs/index.html
}
