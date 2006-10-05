# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/uuagc/uuagc-0.9.1.ebuild,v 1.10 2006/10/05 03:18:44 cparrott Exp $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="The Utrecht University Attribute Grammar system"
HOMEPAGE="http://www.cs.uu.nl/wiki/HUT/AttributeGrammarSystem"
SRC_URI="http://abaris.zoo.cs.uu.nl:8080/wiki/pub/HUT/Download/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
		>=dev-haskell/uulib-0.9.1"
