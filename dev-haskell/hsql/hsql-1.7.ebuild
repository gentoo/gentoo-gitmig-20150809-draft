# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql/hsql-1.7.ebuild,v 1.4 2006/03/01 19:40:51 hansmi Exp $

CABAL_FEATURES="lib haddock"
inherit haskell-cabal

DESCRIPTION="SQL bindings for Haskell"
HOMEPAGE="http://htoolkit.sourceforge.net/"
SRC_URI="mirror://gentoo/HSQL-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"

#if possible try testing with "~ppc" and "~sparc"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="postgres sqlite odbc mysql"

DEPEND=">=virtual/ghc-6.4.1"
PDEPEND="postgres? ( ~dev-haskell/hsql-postgresql-${PV} )
	sqlite? ( ~dev-haskell/hsql-sqlite-${PV} )
	odbc? ( ~dev-haskell/hsql-odbc-${PV} )
	mysql? ( ~dev-haskell/hsql-mysql-${PV} )"

S="${WORKDIR}/HSQL/HSQL"
