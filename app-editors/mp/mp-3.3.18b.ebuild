# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.3.18b.ebuild,v 1.11 2011/03/27 10:20:03 nirbheek Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Minimum Profit: A text editor for programmers"
HOMEPAGE="http://www.triptico.com/software/mp.html"
SRC_URI="http://www.triptico.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-interix ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE="gtk ncurses nls pcre"

RDEPEND="!dev-util/rej
	ncurses? ( sys-libs/ncurses )
	gtk? ( x11-libs/gtk+:2 >=x11-libs/pango-1.8.0 )
	!gtk? ( sys-libs/ncurses )
	nls? ( sys-devel/gettext )
	pcre? ( dev-libs/libpcre )
	 dev-lang/perl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	local myconf="--prefix=${EPREFIX}/usr --without-win32 --without-gtk1"
	tc-export CC

	if use gtk ; then
		! use ncurses && myconf="${myconf} --without-curses"
	else
		myconf="${myconf} --without-gtk2"
	fi

	use nls || myconfig="${myconf} --without-i18n --without-gettext"
	use pcre || myconf="${myconf} --without-pcre --with-included-regex"

	sh config.sh ${myconf} || die "Configure failed"

	echo ${CFLAGS} >> config.cflags
	echo ${LDFLAGS} >> config.ldflags
}

src_install() {
	dobin mp || die "Install Failed"

	use gtk && dosym mp /usr/bin/gmp

	dodoc AUTHORS README Changelog mprc.sample
	doman mp.1
}

pkg_postinst() {
	if use gtk ; then
		einfo
		einfo "mp is symlinked to gmp! Use mp -tx to use text mode!"
		einfo
	fi
}
