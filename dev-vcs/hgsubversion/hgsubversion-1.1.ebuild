# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/hgsubversion/hgsubversion-1.1.ebuild,v 1.5 2010/07/07 17:02:37 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="hgsubversion is a Mercurial extension for working with Subversion"
HOMEPAGE="http://bitbucket.org/durin42/hgsubversion http://pypi.python.org/pypi/hgsubversion"
SRC_URI="http://bitbucket.org/durin42/${PN}/get/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-vcs/mercurial-1.4
		<dev-vcs/mercurial-1.6
		>=dev-vcs/subversion-1.5[python]"
DEPEND="test? ( dev-python/nose )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="README"

S="${WORKDIR}/${PN}"

src_test() {
	cd "${S}/tests"
	testing() {
		"$(PYTHON)" run.py
	}
	python_execute_function testing
}
