# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/mathomatic/mathomatic-12.8.8.ebuild,v 1.5 2010/11/05 22:16:05 bicatali Exp $

inherit eutils

DESCRIPTION="Automatic algebraic manipulator"
HOMEPAGE="http://www.mathomatic.org/"
SRC_URI="${HOMEPAGE}/archive/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc"

DEPEND="sys-libs/readline
	sys-libs/ncurses"

src_compile() {
	# respect user flags
	sed -i \
		-e '/^CFLAGS/ s/-O.//' \
		-e '/^LDFLAGS/s/+= -lm/:= -lm $(LDFLAGS)/' \
		makefile primes/makefile || die "sed failed"
	emake READLINE=1 || die "emake failed"
	emake -C primes || die "emake in primes failed"
}

src_test() {
	emake test || die "emake test failed"
	emake -C primes test || die "emake test in primes failed"
}

src_install() {
	# It was easier just to install the files manually
	dobin mathomatic primes/matho-{primes,pascal,sumsq} || die
	dodoc changes.txt README.txt AUTHORS || die
	doman mathomatic.1 primes/*.1 || die
	doicon mathomatic.png || die
	domenu mathomatic.desktop || die
	newdoc primes/README.txt README-primes.txt || die
	if use doc; then
		dohtml doc/* || die
		insinto /usr/share/doc/${PF}
		doins -r tests factorial m4 || die
	fi
}
