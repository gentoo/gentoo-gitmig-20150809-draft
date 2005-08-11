# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.40_pre3.ebuild,v 1.1 2005/08/11 23:49:47 truedfx Exp $

inherit flag-o-matic

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~truedfx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	dev-lang/perl"
S=${WORKDIR}/${P%_pre*}

add_flag() {
	for flag in "$@"; do
		if test_flag "$flag" >/dev/null; then
			append-flags "$flag"
			return
		fi
	done
}

src_compile() {
	add_flag -std=c99 -ansi
	add_flag -pedantic
	add_flag -Wall
	add_flag -Wextra -W
	emake || die
}

src_install() {
	newsbin ufed.pl ufed || die
	doman ufed.8
	dodoc ChangeLog
	insinto /usr/lib/ufed
	doins *.pm
	exeinto /usr/lib/ufed
	doexe ufed-curses
}
