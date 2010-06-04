# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tempita/tempita-0.4.ebuild,v 1.1 2010/06/04 06:36:32 djc Exp $

EAPI=3
SUPPORT_PYTHON_ABIS=1

inherit distutils

MY_PN="Tempita"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A very small text templating language"
HOMEPAGE="http://pythonpaste.org/tempita"
SRC_URI="http://pypi.python.org/packages/source/T/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-python/setuptools
		test? ( dev-python/nose )"
RDEPEND=""

RESTRICT_PYTHON_ABIS="3.*"
S="${WORKDIR}/${MY_P}"
