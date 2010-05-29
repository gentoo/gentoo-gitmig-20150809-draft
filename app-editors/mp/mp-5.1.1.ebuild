# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-5.1.1.ebuild,v 1.5 2010/05/29 19:34:36 armin76 Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Minimum Profit: A text editor for programmers"
HOMEPAGE="http://www.triptico.com/software/mp.html"
SRC_URI="http://www.triptico.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="gtk ncurses nls pcre iconv"

RDEPEND="ncurses? ( sys-libs/ncurses )
	gtk? ( >=x11-libs/gtk+-2 >=x11-libs/pango-1.8.0 )
	!gtk? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )
	pcre? ( dev-libs/libpcre )
	iconv? ( virtual/libiconv )
	app-text/grutatxt"
DEPEND="${RDEPEND}
	app-text/grutatxt
	dev-util/pkgconfig
	dev-lang/perl"

src_configure() {
	local myconf="--prefix=${EPREFIX}/usr --without-win32"

	if use gtk; then
		! use ncurses && myconf="${myconf} --without-curses"
	else
		myconf="${myconf} --without-gtk2"
	fi

	use nls || myconfig="${myconf} --without-gettext"

	myconf="${myconf} $(use_with pcre)"
	use pcre || myconf="${myconf} --with-included-regex"

	use iconv || myconf="${myconf} --without-iconv"

	sh config.sh ${myconf} || die "Configure failed"

	echo ${CFLAGS} >> config.cflags
	echo ${LDFLAGS} >> config.ldflags
}

src_install() {
	dodir /usr/bin
	sh config.sh --prefix="${EPREFIX}/usr"
	make DESTDIR="${D}" install || die "Install Failed"
	use gtk && dosym mp-5 /usr/bin/gmp
}

pkg_postinst() {
	if use gtk ; then
		einfo
		einfo "mp-5 is symlinked to gmp! Use"
		einfo "$ DISPLAY=\"\" mp-5"
		einfo "to use text mode!"
		einfo
	fi
}
