# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdata/gdata-1.0.4.ebuild,v 1.1 2007/07/03 11:43:18 lucass Exp $

inherit distutils

MY_P="gdata.py-${PV}"

DESCRIPTION="Python client library for Google data APIs"
HOMEPAGE="http://code.google.com/p/gdata-python-client/"
SRC_URI="http://gdata-python-client.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND="|| ( >=dev-lang/python-2.5 dev-python/elementtree )"

PYTHON_MODNAME="atom gdata"
S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r samples
	fi
}

src_test() {
	cd tests
	export PYTHONPATH=../src
	for x in $(find -name "*.py"); do
		grep -q raw_input ${x} && continue
		einfo "Running ${x}..."
		"${python}" ${x} -v || die "${x} failed"
	done
}
