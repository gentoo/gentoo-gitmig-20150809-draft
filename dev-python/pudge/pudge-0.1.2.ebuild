# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pudge/pudge-0.1.2.ebuild,v 1.1 2007/01/07 21:33:35 dev-zero Exp $

inherit distutils

DESCRIPTION="A documentation generator for Python projects, using Restructured Text"
HOMEPAGE="http://pudge.lesscode.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-python/docutils
	<=dev-python/kid-0.9.3"
DEPEND="dev-python/setuptools"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/use_setuptools/d' \
		-e '/install_requires[ \t]*=[ \t]*\[.*\],/d' \
		-e '/install_requires/, /],/d' \
		setup.py || die "sed failed"
}

src_install() {
	distutils_src_install
	if use doc ; then
		einfo "Generating docs as requested..."
		./bin/pudge --modules=pudge --documents=doc/index.rst --dest=doc/html
		dohtml -r doc/html/*
	fi
}
