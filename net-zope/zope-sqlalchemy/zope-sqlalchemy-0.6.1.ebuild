# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-sqlalchemy/zope-sqlalchemy-0.6.1.ebuild,v 1.1 2011/01/08 22:32:22 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Minimal Zope/SQLAlchemy transaction integration"
HOMEPAGE="http://pypi.python.org/pypi/zope.sqlalchemy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/sqlalchemy-0.5.1
	net-zope/transaction
	net-zope/zope-interface"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt CREDITS.txt src/zope/sqlalchemy/README.txt"
PYTHON_MODNAME="${PN/-//}"
