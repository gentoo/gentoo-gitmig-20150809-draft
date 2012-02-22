# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/netifaces/netifaces-0.5.ebuild,v 1.3 2012/02/22 08:34:34 patrick Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils python

DESCRIPTION="Portable network interface information"
HOMEPAGE="http://alastairs-place.net/netifaces/"
SRC_URI="http://alastairs-place.net/2007/03/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
