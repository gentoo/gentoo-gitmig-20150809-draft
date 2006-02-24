# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.40-r1.ebuild,v 1.2 2006/02/24 19:54:27 corsair Exp $

inherit eutils

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~truedfx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-useorder.patch
}

src_compile() {
	./configure || die "configure failed"
	emake || die "make failed"
}

src_install() {
	newsbin ufed.pl ufed
	doman ufed.8
	insinto /usr/lib/ufed
	doins *.pm
	exeinto /usr/lib/ufed
	doexe ufed-curses
}
