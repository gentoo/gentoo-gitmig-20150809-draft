# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/uuagc/uuagc-0.9.1.ebuild,v 1.3 2006/02/16 13:30:48 dcoutts Exp $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="The Utrecht University Attribute Grammar system"
HOMEPAGE="http://www.cs.uu.nl/wiki/HUT/AttributeGrammarSystem"
SRC_URI="http://abaris.zoo.cs.uu.nl:8080/wiki/pub/HUT/Download/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"	#if possible try testing with "~ppc" and "~sparc"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2
		>=dev-haskell/uulib-0.9.1"
