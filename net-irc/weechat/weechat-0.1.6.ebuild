# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-0.1.6.ebuild,v 1.2 2006/02/17 21:26:16 swegener Exp $

DESCRIPTION="Portable and multi-interface IRC client."
HOMEPAGE="http://weechat.flashtux.org/"
SRC_URI="http://weechat.flashtux.org/download/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="debug perl python ruby ssl"

DEPEND="sys-libs/ncurses
	perl? ( dev-lang/perl )
	python? ( virtual/python )
	ruby? ( dev-lang/ruby )
	ssl? ( net-libs/gnutls )"

src_compile() {
	econf \
		--enable-curses \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_enable ruby) \
		$(use_enable ssl gnutls) \
		$(use_with debug debug 2) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README TODO || die "dodoc failed"
}
