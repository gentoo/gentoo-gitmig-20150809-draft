# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/4suite/4suite-1.0_beta1.ebuild,v 1.6 2006/08/13 22:59:08 weeve Exp $

inherit distutils eutils

MY_P=${P/_beta/b}
MY_P=${MY_P/4s/4S}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Python tools for XML processing and object-databases."
SRC_URI="mirror://sourceforge/foursuite/${MY_P}.tar.bz2"
HOMEPAGE="http://www.4suite.org/"

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pyxml-0.8.3"

IUSE="doc"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc sparc ~x86"
LICENSE="Apache-1.1"

PYTHON_MODNAME="Ft"
DOCS="docs/*.txt"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/4S-1.0_a4.addrootopt-gentoo.diff
	python setup.py config --prefix=/usr --docdir=/usr/share/doc/${P}
}

src_install() {
	if use doc; then
		distutils_src_install --with-docs
		else
		distutils_src_install
	fi
}
