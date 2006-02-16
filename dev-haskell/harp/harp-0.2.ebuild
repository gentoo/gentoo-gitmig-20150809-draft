# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/harp/harp-0.2.ebuild,v 1.2 2006/02/16 13:25:24 dcoutts Exp $

CABAL_FEATURES="haddock lib"
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

