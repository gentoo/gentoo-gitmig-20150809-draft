# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-iwscan/python-iwscan-20080402.ebuild,v 1.9 2010/12/25 17:00:56 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="A Python extension for iwscan access"
HOMEPAGE="http://projects.otaku42.de/browser/python-iwscan"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
