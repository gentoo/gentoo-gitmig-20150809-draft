# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnuplot-py/gnuplot-py-1.7-r1.ebuild,v 1.1 2005/06/04 15:18:26 fserb Exp $

inherit distutils

DESCRIPTION="A python wrapper for Gnuplot"
HOMEPAGE="http://gnuplot-py.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~s390 ~x86"
IUSE=""

DEPEND="virtual/python
	media-gfx/gnuplot
	dev-python/numeric"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-mousesupport.patch
}

src_install() {
	distutils_src_install
	dohtml doc/Gnuplot/*
	insinto /usr/share/doc/${PF}
	doins demo.py
}
