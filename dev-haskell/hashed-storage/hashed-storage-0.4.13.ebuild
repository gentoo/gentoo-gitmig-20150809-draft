# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hashed-storage/hashed-storage-0.4.13.ebuild,v 1.2 2010/07/08 12:54:25 slyfox Exp $

EAPI=2

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Hashed file storage support code."
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/hashed-storage"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc64 ~x86"
IUSE="test"

RDEPEND=">=dev-lang/ghc-6.10
		dev-haskell/binary
		dev-haskell/dataenc
		=dev-haskell/mmap-0.4*
		dev-haskell/mtl
		dev-haskell/zlib"
DEPEND=">=dev-haskell/cabal-1.6
		test? (
			dev-haskell/test-framework
			dev-haskell/test-framework-hunit
			dev-haskell/test-framework-quickcheck2
			dev-haskell/zip-archive
		)
		${RDEPEND}"

src_configure() {
	cabal_src_configure $(cabal_flag test)
}

src_install() {
	cabal_src_install

	rm "${D}/usr/bin/hashed-storage-test" 2> /dev/null
	rmdir "${D}/usr/bin" 2> /dev/null # only if empty
}
