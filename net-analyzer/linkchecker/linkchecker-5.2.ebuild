# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/linkchecker/linkchecker-5.2.ebuild,v 1.6 2011/04/27 09:35:57 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_MODNAME="linkcheck"

inherit distutils eutils

MY_P="${P/linkchecker/LinkChecker}"

DESCRIPTION="Check websites for broken links"
HOMEPAGE="http://linkchecker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~ppc-macos ~x64-solaris"
IUSE="X"

DEPEND="X? ( dev-python/PyQt4[X,assistant] )"
RDEPEND="${DEPEND}"

RESTRICT="test"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-missing-files.patch
	distutils_src_prepare
}

src_install() {
	distutils_src_install
	if ! use X; then
		rm -rf \
			"${ED}"/usr/bin/linkchecker-gui \
			"${ED}"/$(python_get_sitedir)/linkcheck/gui || die
	fi
}
