# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdata/gdata-1.0.8.ebuild,v 1.15 2009/04/28 12:02:25 armin76 Exp $

inherit distutils eutils

MY_P="gdata.py-${PV}"

DESCRIPTION="Python client library for Google data APIs"
HOMEPAGE="http://code.google.com/p/gdata-python-client/"
SRC_URI="http://gdata-python-client.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="examples"

DEPEND=""
RDEPEND="|| ( >=dev-lang/python-2.5 dev-python/elementtree )"

PYTHON_MODNAME="atom gdata"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	distutils_src_unpack

	epatch "${FILESDIR}/${P}-test-fix.patch"
}

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
