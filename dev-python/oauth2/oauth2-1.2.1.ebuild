# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oauth2/oauth2-1.2.1.ebuild,v 1.2 2010/09/29 01:20:58 mr_bones_ Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Library for OAuth version 1.0a."
HOMEPAGE="http://pypi.python.org/pypi/oauth2"
SRC_URI="http://github.com/simplegeo/python-oauth2/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/mox dev-python/coverage )"
RDEPEND=""

S="${WORKDIR}/simplegeo-python-${PN}-d8cdf31"
