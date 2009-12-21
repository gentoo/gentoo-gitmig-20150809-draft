# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lockfile/lockfile-0.8.ebuild,v 1.1 2009/12/21 02:33:23 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Platform-independent file locking module"
HOMEPAGE="http://smontanaro.dyndns.org/python/ http://pypi.python.org/pypi/lockfile"
SRC_URI="http://smontanaro.dyndns.org/python/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="ACKS README RELEASE-NOTES"
PYTHON_MODNAME="lockfile.py"

src_install() {
	distutils_src_install

	if use doc; then
		docinto doc
		dodoc doc/* || die "Installation of documentation failed"
	fi
}
