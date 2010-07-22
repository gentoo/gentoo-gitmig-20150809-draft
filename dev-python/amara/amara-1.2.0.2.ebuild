# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/amara/amara-1.2.0.2.ebuild,v 1.2 2010/07/22 14:39:48 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="${P/amara/Amara}"

DESCRIPTION="Python tools for XML processing."
HOMEPAGE="http://uche.ogbuji.net/tech/4suite/amara/ http://pypi.python.org/pypi/Amara"
SRC_URI="ftp://ftp.4suite.org/pub/Amara/${MY_P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples"

RDEPEND=">=dev-python/4suite-1.0.2"
DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )"

S="${WORKDIR}/${MY_P}"

DOCS="ACKNOWLEDGEMENTS CHANGES README TODO docs/quickref.txt"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		epydoc build-$(PYTHON -f --ABI)/lib/amara || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r html/* || die "dohtml failed"
	fi

	if use examples; then
		insinto /usr/share/${PN}
		doins -r demo || die "doins failed"
	fi
}
