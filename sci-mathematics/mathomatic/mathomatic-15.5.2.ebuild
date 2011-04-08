# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/mathomatic/mathomatic-15.5.2.ebuild,v 1.1 2011/04/08 03:47:54 bicatali Exp $

EAPI=4
inherit eutils toolchain-funcs

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

src_prepare() {
	sed -i -e 's/time -p//g' makefile primes/makefile || die
}

src_compile() {
	emake READLINE=1 CC=$(tc-getCC)
	emake CC=$(tc-getCC) -C primes
}

src_test() {
	emake test
	emake -C primes test
}

src_install() {
	dobin mathomatic
	dobin primes/matho-{mult,primes,pascal,sumsq} primes/primorial
	dodoc changes.txt README.txt AUTHORS
	doman mathomatic.1 primes/*.1
	doicon icons/mathomatic.png
	domenu icons/mathomatic.desktop
	newdoc primes/README.txt README-primes.txt
	if use doc; then
		dohtml doc/*
		insinto /usr/share/doc/${PF}
		doins -r tests factorial m4
	fi
}
