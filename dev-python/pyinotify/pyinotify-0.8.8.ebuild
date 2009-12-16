# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyinotify/pyinotify-0.8.8.ebuild,v 1.4 2009/12/16 21:10:12 maekke Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python module used for monitoring filesystems events"
HOMEPAGE="http://trac.dbzteam.org/pyinotify http://pypi.python.org/pypi/pyinotify"
SRC_URI="http://seb.dbzteam.org/pub/pyinotify/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc examples"

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${PN}"

PYTHON_MODNAME="pyinotify.py"
DOCS="NEWS TODO"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml docstrings/* || die "dohtml failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins examples/* || die "doins failed"
	fi
}
