# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/lhs2tex/lhs2tex-1.10_pre.ebuild,v 1.13 2008/09/03 21:03:25 opfer Exp $

DESCRIPTION="Preprocessor for typesetting Haskell sources with LaTeX"
HOMEPAGE="http://www.iai.uni-bonn.de/~loeh/lhs2tex"
SRC_URI="http://www.iai.uni-bonn.de/~loeh/lhs2tex/${P/_pre/pre}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc64 ~sparc x86"
IUSE="doc"

S="${WORKDIR}/${P/_pre/pre}"

DEPEND=">=dev-tex/polytable-0.7.2
	>=dev-lang/ghc-5.04
	!>=dev-lang/ghc-6.6
	doc? ( dev-lang/hugs98 )
	virtual/latex-base"

src_compile() {
	# polytable is installed separately
	econf --disable-polytable || die "econf failed"
	# if doc is set, we build the documentation instead
	# of using the prebuilt file
	use doc && rm doc/Guide2.dontbuild
	emake -j1 || die "make failed"
}

src_install () {
	DESTDIR="${D}" emake -j1 install || die "installation failed"
	dodoc doc/Guide2.pdf
	dodoc INSTALL RELEASE
}
