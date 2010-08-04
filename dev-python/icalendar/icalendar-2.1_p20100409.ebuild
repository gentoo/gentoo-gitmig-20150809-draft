# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/icalendar/icalendar-2.1_p20100409.ebuild,v 1.3 2010/08/04 11:49:33 nixphoeni Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"

inherit eutils distutils

MY_P="${PN}-${PV%%_p*}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Package used for parsing and generating iCalendar files (RFC 2445)."
HOMEPAGE="http://codespeak.net/icalendar/ http://pypi.python.org/pypi/icalendar"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt CREDITS.txt doc/* HISTORY.txt README.txt TODO.txt"

src_prepare() {
	EPATCH_SUFFIX="patch" epatch "${FILESDIR}/${PV}"
	distutils_src_prepare
}

src_test() {
	testing() {
		"$(PYTHON)" test.py
	}
	python_execute_function testing
}
