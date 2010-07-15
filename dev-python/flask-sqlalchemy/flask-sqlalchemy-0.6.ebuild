# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-sqlalchemy/flask-sqlalchemy-0.6.ebuild,v 1.1 2010/07/15 17:43:36 robbat2 Exp $

EAPI=3
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="Flask-SQLAlchemy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SQLAlchemy support for Flask applications"
HOMEPAGE="http://pypi.python.org/pypi/Flask-SQLAlchemy/"
SRC_URI="http://pypi.python.org/packages/source/F/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/setuptools
	dev-python/flask"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}
