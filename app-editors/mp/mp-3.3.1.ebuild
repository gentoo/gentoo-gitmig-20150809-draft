# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.3.1.ebuild,v 1.5 2004/08/27 12:04:47 mr_bones_ Exp $

DESCRIPTION="Minimum Profit: A text editor for programmers"
HOMEPAGE="http://www.triptico.com/software/mp.html"
SRC_URI="http://www.triptico.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE="ncurses gtk"

DEPEND="virtual/libc
		ncurses? ( sys-libs/ncurses )
		gtk? ( >=x11-libs/gtk+-1.2* )
		!gtk? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}
		dev-lang/perl"

src_compile() {
	local myconf

	if use gtk ; then
		if use ncurses ; then
			sh config.sh ${myconf}|| die "Configure Failed"
		else
			myconf="${myconf} --without-curses"
			sh config.sh ${myconf} || die "Configure Failed"
		fi
	else
		myconf="${myconf} --without-gtk"
		sh config.sh ${myconf} || die "Configure Failed"
	fi
	echo ${CFLAGS} >> config.cflags
	emake || die "Compile Failed"
}

src_install() {
	dobin mp || die "Install Failed"
	use gtk && dosym mp "${DESTTREE}/bin/gmp"
	dodoc AUTHORS README Changelog mprc.sample
	doman mp.1
}
