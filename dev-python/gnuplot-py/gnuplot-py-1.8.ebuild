# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnuplot-py/gnuplot-py-1.8.ebuild,v 1.1 2008/07/05 10:01:59 bicatali Exp $

inherit distutils eutils

DESCRIPTION="A python wrapper for Gnuplot"
HOMEPAGE="http://gnuplot-py.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="virtual/python"
RDEPEND="sci-visualization/gnuplot
	dev-python/numpy"

PYTHON_MODNAME="Gnuplot"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.7-mousesupport.patch"
}

src_install() {
	distutils_src_install
	dodoc {ANNOUNCE,CREDITS,NEWS,TODO,FAQ}.txt
	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r doc/Gnuplot/* || die "doc install failed"
	fi
}
