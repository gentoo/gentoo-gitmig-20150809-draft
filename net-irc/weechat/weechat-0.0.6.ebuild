# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-0.0.6.ebuild,v 1.3 2004/07/17 15:05:27 swegener Exp $

DESCRIPTION="Portable and multi-interface IRC client."
HOMEPAGE="http://weechat.flashtux.org/"
SRC_URI="http://weechat.flashtux.org/download/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="debug gtk ncurses perl"

RDEPEND="gtk? ( =x11-libs/gtk+-2* )
	perl? ( dev-lang/perl )"
DEPEND="${RDEPEND}
	ncurses? ( sys-libs/ncurses )
	gtk? ( dev-util/pkgconfig )"

pkg_setup() {
	use gtk || use ncurses \
		|| die "You must have at least one of gtk or ncurses in USE!"
}

src_compile() {
	local myconf=""
	use ncurses || myconf="${myconf} --disable-curses"
	use gtk     && myconf="${myconf} --enable-gtk"
	use perl    && myconf="${myconf} --enable-perl"
	use debug   && myconf="${myconf} --enable-debug"

	econf ${myconf} || die "Configure failed"
	# Bad configure script is forcing CFLAGS, so we pass our own
	emake CFLAGS="${CFLAGS}" || die "Make failed"
}

src_install() {
	make DESTDIR=${D} install || die "Install failed"
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README TODO || die "dodoc failed"
}
