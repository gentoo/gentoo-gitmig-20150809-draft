# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/lhs2tex/lhs2tex-1.11.ebuild,v 1.12 2010/08/01 12:10:47 slyfox Exp $

DESCRIPTION="Preprocessor for typesetting Haskell sources with LaTeX"
HOMEPAGE="http://www.iai.uni-bonn.de/~loeh/lhs2tex"
SRC_URI="http://www.iai.uni-bonn.de/~loeh/lhs2tex/${P/_pre/pre}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc64 sparc x86"
IUSE="doc"

S="${WORKDIR}/${P/_pre/pre}"

DEPEND=">=dev-tex/polytable-0.8.2
	<dev-lang/ghc-6.8
	=dev-haskell/cabal-1.1.6*"

RDEPEND=">=dev-tex/polytable-0.8.2"

src_unpack() {
	unpack ${A}
	sed -i "s|-package lang||" "${S}/config.mk.in" || die "patch failed"
}

src_compile() {
	# polytable is installed separately
	econf --disable-polytable || die "econf failed"
	emake -j1 || die "make failed"
}

src_install () {
	DESTDIR="${D}" emake -j1 install || die "installation failed"
	use doc || rm "${D}/usr/share/doc/${P}/Guide2.pdf"
	dodoc INSTALL RELEASE
}
