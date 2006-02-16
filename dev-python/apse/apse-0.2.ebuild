# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apse/apse-0.2.ebuild,v 1.4 2006/02/16 22:34:49 marienz Exp $

inherit distutils
MY_PN="${PN/apse/Apse}"

DESCRIPTION="Approximate String Matching in Python."
HOMEPAGE="http://www.personal.psu.edu/staff/i/u/iua1/python/apse/"
SRC_URI="http://www.personal.psu.edu/staff/i/u/iua1/python/apse/dist/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-lang/python
	dev-lang/swig"

S=${WORKDIR}/${MY_PN}-${PV}

PYTHON_MODNAME="Apse"

src_install() {
	distutils_src_install
	dodoc README* *agrep
	insinto /usr/share/doc/${PF}/test
	doins test/*
}

