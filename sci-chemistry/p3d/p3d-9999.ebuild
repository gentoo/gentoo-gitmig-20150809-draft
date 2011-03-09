# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/p3d/p3d-9999.ebuild,v 1.1 2011/03/09 10:34:14 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit git distutils versionator

MY_P="${PN}-$(replace_version_separator 3 -)"
GITHUB_ID="gb8b9a75"

DESCRIPTION="Python module for structural bioinformatics"
HOMEPAGE="http://p3d.fufezan.net"
SRC_URI=""
EGIT_REPO_URI="git://github.com/fu/p3d.git"

SLOT="0"
KEYWORDS=""
LICENSE="GPL-3"
IUSE="examples"

S="${WORKDIR}"/${PN}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/${PN}
		doins -r pdbs exampleScripts
	fi
}
