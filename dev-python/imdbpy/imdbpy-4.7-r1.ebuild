# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/imdbpy/imdbpy-4.7-r1.ebuild,v 1.3 2012/02/22 08:09:26 patrick Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils eutils

MY_PN="IMDbPY"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python package to access the IMDb movie database"
HOMEPAGE="http://imdbpy.sourceforge.net/ http://pypi.python.org/pypi/IMDbPY"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS="docs/AUTHOR.txt docs/FAQS.txt docs/imdbpy47.dtd docs/imdbpy.cfg docs/README*"
PYTHON_MODNAME="imdb"

set_global_options() {
	if [[ "$(python_get_implementation)" == "Jython" ]]; then
		DISTUTILS_GLOBAL_OPTIONS=("--without-cutils")
	else
		DISTUTILS_GLOBAL_OPTIONS=()
	fi
}

distutils_src_compile_pre_hook() {
	set_global_options
}

distutils_src_install_pre_hook() {
	set_global_options
}

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-4.6-data_location.patch"
}
