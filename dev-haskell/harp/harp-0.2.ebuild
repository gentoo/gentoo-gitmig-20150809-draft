# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/harp/harp-0.2.ebuild,v 1.1 2005/10/24 15:03:06 araujo Exp $

CABAL_FEATURES="haddock"
inherit haskell-cabal

DESCRIPTION="Functions that simulate the behavior of regular patterns using a Match monad for parsing lists"
HOMEPAGE="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/"
SRC_URI="http://www.cs.chalmers.se/~d00nibro/haskell-src-exts/haskell-src-exts-${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/ghc"

S=${WORKDIR}/haskell-src-exts/src/harp

