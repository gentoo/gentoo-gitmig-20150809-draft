# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/lhs2tex/lhs2tex-1.9.ebuild,v 1.4 2005/01/01 18:05:45 eradicator Exp $

SRC_URI="http://www.cs.uu.nl/~andres/lhs2tex/${P}.tar.bz2"

IUSE="doc"

DESCRIPTION="Preprocessor for typesetting Haskell sources with LaTeX"
HOMEPAGE="http://www.cs.uu.nl/~andres/lhs2tex"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-tex/polytable-0.7.2
	>=virtual/ghc-5.04
	doc? ( dev-lang/hugs98 )
	virtual/tetex"

src_compile() {
	# polytable is installed separately
	econf --disable-polytable || die "econf failed"
	# if doc is set, we build the documentation instead
	# of using the prebuilt file
	use doc && rm doc/Guide2.dontbuild
	# emake doesn't work because lhs2TeX interactive calls are
	# broken
	make || die "make failed"
}

src_install () {
	DESTDIR="${D}" make install || die "installation failed"
	dodoc doc/Guide2.pdf
	dodoc INSTALL RELEASE
}
