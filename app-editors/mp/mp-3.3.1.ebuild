# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.3.1.ebuild,v 1.3 2004/08/27 11:51:49 mr_bones_ Exp $

DESCRIPTION="Minimum Profit: A text editor for programmers"
HOMEPAGE="http://www.triptico.com/software/mp.html"
SRC_URI="http://www.triptico.com/download/mp-3.3.1.tar.gz"

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
	if use ncurses && use gtk ; then
		sh config.sh ${myconf}|| die "Configure Failed"
	elif use ncurses || ! use gtk ; then
		myopts="${myopts} --without-gtk"
		sh config.sh ${myconf} || die "Configure Failed"
	elif use gtk && ! use ncurses ; then
		myopts="${myopts} --without-curses"
		sh config.sh ${myconf} || die "Configure Failed"
	fi
	echo ${CFLAGS} >> config.cflags
	emake || die "Compile Failed"
}

src_install() {
	dobin mp || die "Install Failed"
	dosym mp ${DESTTREE}/bin/gmp

	dodoc AUTHORS README Changelog mprc.sample

	doman mp.1
}
