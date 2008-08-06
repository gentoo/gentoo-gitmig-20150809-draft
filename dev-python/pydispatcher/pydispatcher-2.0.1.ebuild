# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydispatcher/pydispatcher-2.0.1.ebuild,v 1.1 2008/08/06 05:46:21 neurogeek Exp $

inherit distutils

MY_P="PyDispatcher"-${PV}

DESCRIPTION="Multi-producer-multi-consumer signal dispatching mechanism for Python"
HOMEPAGE="http://pydispatcher.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc examples"
DEPEND="virtual/python"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install
	distutils_python_version

	if use examples; then
		insinto /usr/share/doc/"${PF}"/examples
		doins examples/*
	fi

	if use doc; then
		insinto "${ROOT}/usr/share/doc/${PF}/html"
		doins -r docs/*

		PYTHONPATH=${PYTHONPATH}:/${D}$(python_get_sitedir)
		${python} docs/pydoc/builddocs.py
		dohtml -r *html
	fi

}
