# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ctypes/ctypes-0.9.6.ebuild,v 1.2 2006/02/06 22:30:59 liquidx Exp $

inherit eutils distutils

DESCRIPTION="Python module allowing to create and manipulate C data types."
HOMEPAGE="http://starship.python.net/crew/theller/ctypes/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.3.3"

DOCS="README.txt NEWS.txt LICENSE.txt docs/*"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/ctypes-gcc4
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}
	doins -r samples/*
}