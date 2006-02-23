# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc/hdbc-0.99.0.ebuild,v 1.1 2006/02/23 10:45:26 dcoutts Exp $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

DESCRIPTION="Haskell Database Connectivity"
HOMEPAGE="http://quux.org/devel/hdbc/"
SRC_URI="http://quux.org/devel/hdbc/${PN}_${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~x86 ~amd64"	#if possible try testing with "~ppc" and "~sparc"
IUSE="postgres sqlite odbc"

DEPEND=">=virtual/ghc-6.4.1"
PDEPEND="postgres? ( =dev-haskell/hdbc-postgresql-${PV}* )
		 sqlite? ( =dev-haskell/hdbc-sqlite-${PV}* )
		 odbc? ( =dev-haskell/hdbc-odbc-${PV}* )"

S="${WORKDIR}/${PN}"
