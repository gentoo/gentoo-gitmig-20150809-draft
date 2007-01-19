# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webpy/webpy-0.2.ebuild,v 1.1 2007/01/19 09:01:30 wrobel Exp $

inherit distutils

MY_PN="web.py"

DESCRIPTION="A small and simple web framework for python"
HOMEPAGE="http://www.webpy.org"
SRC_URI="http://www.webpy.org/${MY_PN}-${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_test() {
	TESTS="db template net http utils"

	cd ${S}

	for TEST in ${TESTS}
	do
		${python} web/${TEST}.py || die "Doctest in web/${TEST}.py failed!"
	done
}
