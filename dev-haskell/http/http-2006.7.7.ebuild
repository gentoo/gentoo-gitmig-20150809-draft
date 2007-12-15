# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/http/http-2006.7.7.ebuild,v 1.4 2007/12/15 16:34:50 dcoutts Exp $

CABAL_FEATURES="lib profile haddock"
inherit base versionator eutils haskell-cabal

MY_PV_YEAR=$(get_version_component_range 1)
MY_PV_MONTH=$(get_version_component_range 2)
(( ${MY_PV_MONTH} < 10 )) && MY_PV_MONTH="0${MY_PV_MONTH}"
MY_PV_DAY=$(get_version_component_range 3)
(( ${MY_PV_DAY} < 10 )) && MY_PV_DAY="0${MY_PV_DAY}"
MY_PV="${MY_PV_YEAR}${MY_PV_MONTH}${MY_PV_DAY}"

DESCRIPTION="Haskell HTTP Package"
HOMEPAGE="http://www.haskell.org/http/"
SRC_URI="http://www.haskell.org/http/download/${PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
		>=dev-haskell/network-1.0"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	cabal_src_install

	dodoc README
}
