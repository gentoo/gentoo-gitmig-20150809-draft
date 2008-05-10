# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elementtree/elementtree-1.2.6-r2.ebuild,v 1.9 2008/05/10 16:03:03 jer Exp $

inherit distutils

MY_P="${PN}-${PV}-20050316"
DESCRIPTION="A light-weight XML object model for Python"
HOMEPAGE="http://effbot.org/zone/element-index.htm"
SRC_URI="http://effbot.org/downloads/${MY_P}.tar.gz"

LICENSE="ElementTree"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="dev-python/setuptools"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's/distutils.core/setuptools/' setup.py || die 'sed failed'
}

src_test() {
	python selftest.py || die "selftest.py failed"
}

src_install() {
	distutils_src_install
	dodoc CHANGES
	dohtml docs/*
}
