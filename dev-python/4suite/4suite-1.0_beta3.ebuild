# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4suite/4suite-1.0_beta3.ebuild,v 1.7 2006/08/23 01:34:20 weeve Exp $

inherit distutils eutils

MY_PV=${PV/_beta/b}
S=${WORKDIR}/4Suite-${MY_PV}
DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="ftp://ftp.4suite.org/pub/4Suite/4Suite-XML-${MY_PV}.tar.gz"
HOMEPAGE="http://www.4suite.org/"

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pyxml-0.8.4"

IUSE="doc"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ppc ppc64 sparc x86"
LICENSE="Apache-1.1"

PYTHON_MODNAME="Ft"
DOCS="docs/*.txt"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/1.0_b3-add_root_opt.diff
	python setup.py config --prefix=/usr --docdir=/usr/share/doc/${P}
}

src_install() {
	if use doc; then
		distutils_src_install --with-docs
		else
		distutils_src_install
	fi
}
