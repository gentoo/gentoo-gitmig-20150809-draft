# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/imdbpy/imdbpy-4.3.ebuild,v 1.1 2009/11/21 05:26:42 cardoe Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="IMDbPY"
RESTRICT_PYTHON_ABIS="3.*"

DESCRIPTION="Python package to access the IMDb movie database"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://imdbpy.sourceforge.net/"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
IUSE=""

S="${WORKDIR}/${MY_PN}-${PV}"

src_install() {
	distutils_src_install
	dodoc docs/*
}
