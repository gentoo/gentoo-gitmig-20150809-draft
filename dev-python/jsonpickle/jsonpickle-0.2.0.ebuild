# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jsonpickle/jsonpickle-0.2.0.ebuild,v 1.1 2009/06/19 07:48:17 dev-zero Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Python library for serializing any arbitrary object graph into JSON."
HOMEPAGE="http://code.google.com/p/jsonpickle/"
SRC_URI="http://jsonpickle.googlecode.com/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="|| ( >=dev-lang/python-2.6
	( dev-lang/python:2.5 dev-python/simplejson ) )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e '/install_requires/d' \
		setup.py || die "sed failed"
	sed -i \
		-e '/thirdparty/d' \
		jsonpickle/tests/__init__.py || die "sed failed"
}

src_test() {
	PYTHONPATH="./build/lib" "${python}" setup.py test || die "tests failed"
}
