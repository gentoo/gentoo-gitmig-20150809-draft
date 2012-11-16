# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cov-core/cov-core-1.7.ebuild,v 1.1 2012/11/16 18:47:46 chutzpah Exp $

EAPI="4"

PYTHON_COMPAT=(python2_7 python3_2 python3_3)
inherit distutils-r1

DESCRIPTION="plugin core for use by pytest-cov, nose-cov and nose2-cov"
HOMEPAGE="http://amoffat.github.com/sh://bitbucket.org/memedough/cov-core/overview"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pytest
		dev-python/coverage"
DEPEND=""
