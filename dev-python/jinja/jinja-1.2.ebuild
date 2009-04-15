# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jinja/jinja-1.2.ebuild,v 1.6 2009/04/15 20:13:10 maekke Exp $

inherit distutils

MY_PN="Jinja"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A sandboxed template engine providing a Django-like non-XML syntax."
HOMEPAGE="http://jinja.pocoo.org/1/"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="test"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
	test? ( dev-python/py )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# setup.py loads "jinja", we have to avoid it loads an already installed version
	export PYTHONPATH="."
}

src_install() {
	DOCS="CHANGES"
	distutils_src_install

	# Rearraning the docs
	rm -rf "${D}/usr/docs"
	dodoc docs/src/*
	dohtml docs/html/*
}

src_test() {
	cd tests
	py.test || die "tests failed"
}
