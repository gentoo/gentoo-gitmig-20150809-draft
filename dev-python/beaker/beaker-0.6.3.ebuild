# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beaker/beaker-0.6.3.ebuild,v 1.1 2007/03/24 09:53:13 dev-zero Exp $

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
	dev-python/setuptools"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/install_requires = \[.*\],/d' \
		-e '/install_requires/, /],/d' \
		setup.py || die "sed failed"
}
