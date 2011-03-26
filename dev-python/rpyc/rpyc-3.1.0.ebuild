# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpyc/rpyc-3.1.0.ebuild,v 1.2 2011/03/26 22:58:04 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="RPyC"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Remote Python Call (RPyC), a transparent and symmetric RPC library"
HOMEPAGE="http://rpyc.wikidot.com/ http://pypi.python.org/pypi/RPyC"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt"

RDEPEND="crypt? ( dev-python/tlslite )"
DEPEND="${DEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
