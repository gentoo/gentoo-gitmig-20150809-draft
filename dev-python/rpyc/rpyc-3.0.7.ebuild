# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rpyc/rpyc-3.0.7.ebuild,v 1.2 2010/07/23 22:54:40 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Remote python call"
HOMEPAGE="http://rpyc.wikidot.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crypt"

RDEPEND="crypt? ( dev-python/tlslite )"
DEPEND="${DEPEND}
	dev-python/setuptools"
