# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyenchant/pyenchant-1.5.3.ebuild,v 1.3 2009/11/04 11:26:54 maekke Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python wrapper for the Enchant spellchecking wrapper library"
HOMEPAGE="http://pyenchant.sourceforge.net http://pypi.python.org/pypi/pyenchant"
SRC_URI="mirror://sourceforge/pyenchant/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=app-text/enchant-1.4.0
	>=dev-python/setuptools-0.6_alpha11"
RDEPEND="${DEPEND}"
RESTRICT="test"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="enchant"
DOCS="README.txt TODO.txt"

src_test() {
	testing() {
		"$(PYTHON)" setup.py test
	}
	python_execute_function testing
}
