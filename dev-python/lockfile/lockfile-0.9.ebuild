# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lockfile/lockfile-0.9.ebuild,v 1.2 2010/06/24 21:56:08 pacho Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Platform-independent file locking module"
HOMEPAGE="http://code.google.com/p/pylockfile/ http://pypi.python.org/pypi/lockfile http://smontanaro.dyndns.org/python/"
SRC_URI="http://smontanaro.dyndns.org/python/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( dev-python/sphinx )"
RDEPEND=""
RESTRICT_PYTHON_ABIS="2.4 3.*"

DOCS="ACKS README RELEASE-NOTES"

src_compile() {
	distutils_src_compile

	if use doc; then
		cd doc
		einfo "Generation of documentation"
		emake html || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		cd doc/.build/html
		docinto html
		cp -R [a-z]* _static "${ED}usr/share/doc/${PF}/html" || die "Installation of documentation failed"
	fi
}
