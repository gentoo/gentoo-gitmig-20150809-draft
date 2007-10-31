# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/harp/harp-0.2.ebuild,v 1.8 2007/10/31 12:58:14 dcoutts Exp $

CABAL_FEATURES="haddock lib"
inherit haskell-cabal

DESCRIPTION="HaRP, or Haskell Regular Patterns is a Haskell regular expressions extension"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/harp/"
SRC_URI="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/haskell-src-exts-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/ghc"

S=${WORKDIR}/haskell-src-exts/src/harp
