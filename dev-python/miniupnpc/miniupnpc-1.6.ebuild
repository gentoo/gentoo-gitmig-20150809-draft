# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/miniupnpc/miniupnpc-1.6.ebuild,v 1.1 2011/08/09 17:41:19 mgorny Exp $

EAPI=3
SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND=2
RESTRICT_PYTHON_ABIS="3.*"

inherit base distutils

DESCRIPTION="UPnP client library and a simple UPnP client"
HOMEPAGE="http://miniupnp.free.fr/"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( >=net-libs/miniupnpc-1.6-r1
		net-libs/miniupnpc[-python] )
	!net-libs/miniupnpc[python]"
DEPEND="${RDEPEND}"

src_prepare() {
	local PATCHES=(
		"${FILESDIR}"/0001-Link-Python-module-against-the-shared-library.patch
	)

	base_src_prepare
	distutils_src_prepare

	# these will conflict with base miniupnpc ebuild
	# and distutils.eclass is stupid enough to force installing them
	rm -f Changelog.txt README || die
}
