# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.2.10.ebuild,v 1.3 2004/05/31 22:12:03 vapier Exp $

DESCRIPTION="the definitive text editor"
HOMEPAGE="http://www.triptico.com/software/mp.html"
SRC_URI="http://www.triptico.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="ncurses gtk"

DEPEND="virtual/glibc
	ncurses? ( sys-libs/ncurses )
	gtk? ( =x11-libs/gtk+-1.2* )
	!gtk? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_compile() {
	if use ncurses && use gtk ; then
		emake || die
	elif use ncurses || ! use gtk ; then
		emake mp || die
	elif use gtk ; then
		emake gmp || die
	fi
}

src_install() {
	dodir /usr/bin
	make install PREFIX=${D}/usr || die "install failed"
	dodoc AUTHORS Changelog README
	dohtml README.html doc/mp_api.html

	insinto /usr/share/pixmaps/
	doins mp.xpm
}
