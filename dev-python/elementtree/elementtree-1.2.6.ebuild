# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elementtree/elementtree-1.2.6.ebuild,v 1.13 2007/01/24 14:57:41 corsair Exp $

inherit distutils

MY_P="${PN}-${PV}-20050316"
DESCRIPTION="A light-weight XML object model for Python"
HOMEPAGE="http://effbot.org/zone/element-index.htm"
SRC_URI="http://effbot.org/downloads/${MY_P}.tar.gz"
KEYWORDS="alpha amd64 ia64 mips ppc ~ppc64 ~sparc x86 ~x86-fbsd"
LICENSE="ElementTree"
SLOT="0"
IUSE=""
S=${WORKDIR}/${MY_P}

src_test() {
	python selftest.py || die "selftest.py failed"
}

src_install() {
	distutils_src_install

	dodoc CHANGES
	dohtml docs/*
}
