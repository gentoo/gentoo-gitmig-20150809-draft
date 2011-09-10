# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tempita/tempita-0.5.1.ebuild,v 1.2 2011/09/10 17:43:11 jer Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Tempita"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A very small text templating language"
HOMEPAGE="http://pythonpaste.org/tempita http://pypi.python.org/pypi/Tempita"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
