# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pudge/pudge-0.1.3.ebuild,v 1.5 2010/01/02 22:49:03 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A documentation generator for Python projects, using Restructured Text"
HOMEPAGE="http://pudge.lesscode.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-python/docutils
	>=dev-python/kid-0.9.5
	dev-python/pygments"
DEPEND="dev-python/setuptools
	doc? ( ${RDEPEND} )"
RESTRICT_PYTHON_ABIS="2.4 3.*"

src_install() {
	distutils_src_install

	if use doc; then
		einfo "Generation of documentation"
		./bin/pudge --modules=pudge --documents=doc/index.rst --dest=doc/html || die "Generation of documentation failed"
		dohtml -r doc/html/*
	fi
}
