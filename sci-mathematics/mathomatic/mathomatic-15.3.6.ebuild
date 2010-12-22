# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/mathomatic/mathomatic-15.3.6.ebuild,v 1.1 2010/12/22 06:03:45 bicatali Exp $

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

src_compile() {
	emake READLINE=1 OPTFLAGS="" CC=$(tc-getCC) || die "emake failed"
	emake OPTFLAGS="" CC=$(tc-getCC) -C primes || die "emake in primes failed"
}

src_test() {
	emake test || die "emake test failed"
	emake -C primes test || die "emake test in primes failed"
}

src_install() {
	dobin mathomatic || die
	dobin primes/matho-{mult,primes,pascal,sumsq} primes/primorial || die
	dodoc changes.txt README.txt AUTHORS
	doman mathomatic.1 primes/*.1 || die
	doicon icons/mathomatic.png || die
	domenu icons/mathomatic.desktop || die
	newdoc primes/README.txt README-primes.txt || die
	if use doc; then
		dohtml doc/* || die
		insinto /usr/share/doc/${PF}
		doins -r tests factorial m4 || die
	fi
}
