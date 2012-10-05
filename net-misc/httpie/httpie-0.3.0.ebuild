# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/httpie/httpie-0.3.0.ebuild,v 1.1 2012/10/05 13:48:54 vikraman Exp $

EAPI=4

PYTHON_DEPEND="2:2.6 3:3.1"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A CLI, cURL-like tool for humans"
HOMEPAGE="http://httpie.org/ http://pypi.python.org/pypi/httpie"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	|| ( >=dev-lang/python-2.7 dev-python/argparse )
	>=dev-python/requests-0.10.1
	>=dev-python/pygments-1.5"
