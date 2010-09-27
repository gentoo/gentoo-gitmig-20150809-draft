# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/boto/boto-2.0_beta2.ebuild,v 1.1 2010/09/27 11:18:03 djc Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Amazon Web Services API"
HOMEPAGE="http://code.google.com/p/boto/ http://pypi.python.org/pypi/boto"
SRC_URI="http://boto.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
