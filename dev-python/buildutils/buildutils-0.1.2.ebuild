# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/buildutils/buildutils-0.1.2.ebuild,v 1.1 2007/01/07 22:24:50 dev-zero Exp $

inherit distutils

DESCRIPTION="Distutils extensions for developing Python libraries and applications"
HOMEPAGE="http://buildutils.lesscode.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-python/setuptools
	doc? ( dev-python/pudge )"
RDEPEND=""

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
		python setup.py pudge || die "generating docs failed"
		dohtml -r doc/html/*
	fi
}
