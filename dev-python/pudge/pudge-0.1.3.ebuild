# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pudge/pudge-0.1.3.ebuild,v 1.3 2007/07/04 20:16:09 lucass Exp $

inherit distutils

DESCRIPTION="A documentation generator for Python projects, using Restructured Text"
HOMEPAGE="http://pudge.lesscode.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-python/docutils
	>=dev-python/kid-0.9.5"
DEPEND="dev-python/setuptools
	doc? ( ${RDEPEND} )"

src_install() {
	distutils_src_install
	if use doc ; then
		einfo "Generating docs as requested..."
		./bin/pudge --modules=pudge --documents=doc/index.rst --dest=doc/html
		dohtml -r doc/html/*
	fi
}
