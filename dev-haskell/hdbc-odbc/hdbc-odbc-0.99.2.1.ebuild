# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc-odbc/hdbc-odbc-0.99.2.1.ebuild,v 1.2 2006/03/30 16:05:51 dcoutts Exp $

CABAL_FEATURES="lib haddock"
inherit base haskell-cabal versionator

DESCRIPTION="ODBC database driver for HDBC"
HOMEPAGE="http://quux.org/devel/hdbc/"
SRC_URI="http://quux.org/devel/hdbc/${PN}_${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

hdbc_PV=$(get_version_component_range 1-3)

DEPEND=">=virtual/ghc-6.4.1
	~dev-haskell/hdbc-${hdbc_PV}
	>=dev-db/unixODBC-2.2"

S="${WORKDIR}/${PN}"

src_unpack() {
	base_src_unpack

	# temp patch for missing #include. It seems different versions of
	# dev-db/unixODBC #include their headers in each other differently.
	sed -i 's/#include <sqlext.h>/#include <sqlext.h>\n#include <sqlucode.h>/' \
		"${S}/Database/HDBC/ODBC/TypeConv.hsc"
}
