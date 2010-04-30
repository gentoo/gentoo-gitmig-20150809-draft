# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnuplot-py/gnuplot-py-1.8-r1.ebuild,v 1.1 2010/04/30 15:19:46 grobian Exp $

EAPI="3"
inherit distutils eutils

DESCRIPTION="A python wrapper for Gnuplot"
HOMEPAGE="http://gnuplot-py.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc"

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}
	sci-visualization/gnuplot"

PYTHON_MODNAME="Gnuplot"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.7-mousesupport.patch
}

src_install() {
	distutils_src_install
	dodoc ANNOUNCE.txt CREDITS.txt NEWS.txt TODO.txt FAQ.txt
	dodir /usr/share/doc/${PF}/examples
	mv "${ED}"/usr/$(get_libdir)/python*/site-packages/Gnuplot/{test,demo}.py \
		"${ED}"/usr/share/doc/${PF}/examples || die
	if use doc; then
		insinto /usr/share/doc/${PF}/html
		doins -r doc/Gnuplot/* || die "doc install failed"
	fi
}
