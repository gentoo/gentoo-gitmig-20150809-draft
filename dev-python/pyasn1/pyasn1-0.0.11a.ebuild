# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyasn1/pyasn1-0.0.11a.ebuild,v 1.10 2010/07/06 10:41:29 ssuominen Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="ASN.1 types and codecs (BER, CER, DER) implementation."
HOMEPAGE="http://pyasn1.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/suite.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dohtml doc/*
	insinto /usr/share/doc/${PF}
	doins -r examples
}
