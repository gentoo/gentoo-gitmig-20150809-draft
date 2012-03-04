# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/extensible-exceptions/extensible-exceptions-0.1.1.4.ebuild,v 1.1 2012/03/04 03:11:43 gienah Exp $

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour hoogle"
inherit haskell-cabal versionator

MY_PV=$(get_version_component_range '1-3')
MY_P="${PN}-${PV}"

DESCRIPTION="Extensible exceptions"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/extensible-exceptions"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.8.1"
DEPEND=">=dev-haskell/cabal-1.6
		${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

CABAL_CORE_LIB_GHC_PV="7.4.0.20111219 7.4.0.20120126 7.4.1"
