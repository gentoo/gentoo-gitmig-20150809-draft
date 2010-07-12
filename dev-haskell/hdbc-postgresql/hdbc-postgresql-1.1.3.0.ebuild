# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc-postgresql/hdbc-postgresql-1.1.3.0.ebuild,v 1.4 2010/07/12 13:11:43 slyfox Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal versionator

MY_PN=HDBC-postgresql
MY_P=${MY_PN}-${PV}

DESCRIPTION="PostgreSQL database driver for HDBC"
HOMEPAGE="http://software.complete.org/hdbc-postgresql"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

hdbc_PV=$(get_version_component_range 1-3)

DEPEND=">=dev-lang/ghc-6.4.1
		dev-haskell/mtl
		=dev-haskell/hdbc-${hdbc_PV}*
		dev-haskell/parsec
		>=dev-db/postgresql-base-8"

S="${WORKDIR}/${MY_P}"

CABAL_CONFIGURE_FLAGS="--constraint=base<4"

src_unpack() {
	unpack ${A}

	cp "${FILESDIR}/hdbc-postgresql-helper.h" "${FILESDIR}/pgtypes.h" "${S}/"
	sed -i -e 's/GHC-Options: -O2 -Wall/GHC-Options: -fvia-C/' \
		-e '/include-dirs:/d' \
		-e '/^Extensions:/a \
			, ForeignFunctionInterface' \
		"${S}/${MY_PN}.cabal"
	echo "include-dirs: $(pg_config --includedir)," >> "${S}/${MY_PN}.cabal"
	echo "     $(pg_config --includedir-server), ." >> "${S}/${MY_PN}.cabal"

	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
			, old-time' \
			"${S}/${MY_PN}.cabal"
	fi
}
