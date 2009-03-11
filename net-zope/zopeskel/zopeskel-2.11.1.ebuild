# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zopeskel/zopeskel-2.11.1.ebuild,v 1.1 2009/03/11 16:23:15 tupone Exp $

inherit distutils

MY_PN="ZopeSkel"
MY_P=${MY_PN}-${PV}

DESCRIPTION="A collection of skeletons for quickstarting Zope projects."
HOMEPAGE="http://pypi.python.org/pypi/ZopeSkel/"
SRC_URI="http://pypi.python.org/packages/source/Z/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/pastescript"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S=${WORKDIR}/${MY_P}
