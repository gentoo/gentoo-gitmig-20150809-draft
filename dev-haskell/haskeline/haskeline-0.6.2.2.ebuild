# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haskeline/haskeline-0.6.2.2.ebuild,v 1.12 2012/09/12 15:45:34 qnikst Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="A command-line interface for user input, written in Haskell."
HOMEPAGE="http://trac.haskell.org/haskeline"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cabal-1.6
		=dev-haskell/mtl-1.1*
		>=dev-haskell/terminfo-0.3.1.1
		<dev-haskell/utf8-string-0.4"
