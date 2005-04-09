# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.3.12.ebuild,v 1.2 2005/04/09 15:17:22 corsair Exp $

inherit eutils flag-o-matic

DESCRIPTION="Minimum Profit: A text editor for programmers"
HOMEPAGE="http://www.triptico.com/software/mp.html"
SRC_URI="http://www.triptico.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc64"
IUSE="gtk gtk2 ncurses pcre"

DEPEND="virtual/libc
		ncurses? ( sys-libs/ncurses )
		gtk? (
				gtk2?  ( >=x11-libs/gtk+-2 )
				!gtk2? ( =x11-libs/gtk+-1.2* )
				>=x11-libs/pango-1.8.0
			 )
		!gtk? ( sys-libs/ncurses )
		pcre? ( dev-libs/libpcre )"
RDEPEND="${DEPEND}
		 dev-lang/perl"

src_compile() {
	local myconf="--without-win32"

	if use gtk ; then
		! use ncurses && myconf="${myconf} --without-curses"
		! use gtk2 && myconf="${myconf} --without-gtk2"
	else
		myconf="${myconf} --without-gtk1 --without-gtk2"
	fi

	use pcre || myconf="${myconf} --without-pcre --with-included-regex"

	sh config.sh ${myconf} || die "Configure failed"

	echo ${CFLAGS} >> config.cflags
	echo ${LDFLAGS} >> config.ldflags

	emake || die "Compile Failed"
}

src_install() {
	dobin mp || die "Install Failed"

	use gtk && dosym mp ${DESTTREE}/bin/gmp

	dodoc AUTHORS README Changelog mprc.sample
	doman mp.1
}
