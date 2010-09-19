# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fabric/fabric-0.9.2.ebuild,v 1.1 2010/09/19 22:25:32 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="Fabric"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fabric is a simple, Pythonic tool for remote execution and deployment."
HOMEPAGE="http://fabfile.org http://pypi.python.org/pypi/Fabric"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/paramiko-1.7.6"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# PyCrypto is a dependency of paramiko, not Fabric.
	sed -e "/install_requires=/s/'pycrypto <2.1', //" -i setup.py

	find -name "._*" -print0 | xargs -0 rm -f
}
