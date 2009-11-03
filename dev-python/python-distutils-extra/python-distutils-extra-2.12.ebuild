# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-distutils-extra/python-distutils-extra-2.12.ebuild,v 1.1 2009/11/03 21:59:10 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="You can integrate gettext support, themed icons and scrollkeeper based documentation in distutils."
HOMEPAGE="https://launchpad.net/python-distutils-extra"
SRC_URI="http://launchpad.net/python-distutils-extra/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="DistUtilsExtra"
DOCS="doc/FAQ doc/README doc/setup.cfg.example doc/setup.py.example"
