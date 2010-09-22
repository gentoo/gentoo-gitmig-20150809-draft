# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/linkchecker/linkchecker-5.2.ebuild,v 1.3 2010/09/22 19:40:17 hwoarang Exp $

EAPI="3"

PYTHON_DEPEND="2"
PYTHON_MODNAME="linkcheck"

inherit distutils eutils

MY_P="${P/linkchecker/LinkChecker}"

DESCRIPTION="Check websites for broken links"
HOMEPAGE="http://linkchecker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~ppc-macos ~x64-solaris"
IUSE="X"

DEPEND="X? ( dev-python/PyQt4[X,assistant] )"
RDEPEND="${DEPEND}"

RESTRICT="test"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-missing-files.patch
}

src_install() {
	distutils_src_install
	if ! use X; then
		rm -rf \
			"${ED}"/usr/bin/linkchecker-gui \
			"${ED}"/$(python_get_sitedir)/linkcheck/gui || die
	fi
}
