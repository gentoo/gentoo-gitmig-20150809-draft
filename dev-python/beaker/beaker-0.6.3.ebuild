# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beaker/beaker-0.6.3.ebuild,v 1.3 2007/07/11 06:19:47 mr_bones_ Exp $

NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"

MY_PN=Beaker
MY_P=${MY_PN}-${PV}

DESCRIPTION="A simple WSGI middleware to use the Myghty Container API"
HOMEPAGE="http://beaker.groovie.org"
SRC_URI="http://cheeseshop.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
IUSE="test"

RDEPEND="dev-python/myghtyutils"
DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.6_rc3"

S=${WORKDIR}/${MY_P}
