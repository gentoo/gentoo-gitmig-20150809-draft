# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/celementtree/celementtree-0.9.8.ebuild,v 1.1 2005/01/24 06:37:40 pythonhead Exp $

inherit distutils

MY_P="cElementTree-${PV}-20050123"
DESCRIPTION="The cElementTree module is a C implementation of the ElementTree API"
HOMEPAGE="http://effbot.org/zone/celementtree.htm"
SRC_URI="http://effbot.org/downloads/${MY_P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

IUSE="doc"
DEPEND=">=dev-lang/python-2.1.3-r1
	>=dev-python/elementtree-1.2"
S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}/samples
		doins samples/*
		doins selftest.py
	fi
}
