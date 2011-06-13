# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/mathomatic/mathomatic-15.6.2.ebuild,v 1.1 2011/06/13 22:20:57 bicatali Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Automatic algebraic manipulator"
HOMEPAGE="http://www.mathomatic.org/"
SRC_URI="${HOMEPAGE}/archive/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc gnuplot"

DEPEND="sys-libs/readline
	sys-libs/ncurses"
RDEPEND="${DEPEND}
	gnuplot? ( sci-visualization/gnuplot )"

src_compile() {
	emake READLINE=1 CC=$(tc-getCC)
	emake CC=$(tc-getCC) -C primes
}

src_install() {
	emake prefix="${EPREFIX}usr" DESTDIR="${D}" bininstall
	emake prefix="${EPREFIX}usr" DESTDIR="${D}" -C primes install
	dodoc changes.txt README.txt AUTHORS
	newdoc primes/README.txt README-primes.txt
	use doc && emake \
		prefix="${EPREFIX}usr" \
		mathdocdir="${EPREFIX}usr/share/doc/${PF}" \
		DESTDIR="${D}" docinstall
}
