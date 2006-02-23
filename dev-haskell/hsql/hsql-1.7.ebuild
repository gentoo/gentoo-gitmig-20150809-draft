# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql/hsql-1.7.ebuild,v 1.2 2006/02/23 19:41:08 dcoutts Exp $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

DESCRIPTION="SQL bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://gentoo/HSQL-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86 ~amd64"	#if possible try testing with "~ppc" and "~sparc"
IUSE="postgres sqlite odbc mysql"

DEPEND=">=virtual/ghc-6.4.1"
PDEPEND="postgres? ( ~dev-haskell/hsql-postgresql-${PV} )
	sqlite? ( ~dev-haskell/hsql-sqlite-${PV} )
	odbc? ( ~dev-haskell/hsql-odbc-${PV} )
	mysql? ( ~dev-haskell/hsql-mysql-${PV} )"

S="${WORKDIR}/HSQL/HSQL"
