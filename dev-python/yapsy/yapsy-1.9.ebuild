# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/yapsy/yapsy-1.9.ebuild,v 1.2 2012/07/11 10:20:47 xmw Exp $

EAPI="4"

#bug 423107
#DISTUTILS_SRC_TEST="setup.py"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A fat-free DIY Python plugin management toolkit"
HOMEPAGE="http://yapsy.sourceforge.net/"
SRC_URI="mirror://sourceforge/yapsy/Yapsy-${PV}/Yapsy-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-python/setuptools"
RDEPEND=""
S="${WORKDIR}/Yapsy-${PV}"
