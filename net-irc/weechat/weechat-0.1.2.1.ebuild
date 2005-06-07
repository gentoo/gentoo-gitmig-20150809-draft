# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-0.1.2.1.ebuild,v 1.1 2005/06/07 15:47:56 swegener Exp $

DESCRIPTION="Portable and multi-interface IRC client."
HOMEPAGE="http://weechat.flashtux.org/"
SRC_URI="http://weechat.flashtux.org/download/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="debug perl python"

DEPEND="sys-libs/ncurses
	perl? ( dev-lang/perl )
	python? ( virtual/python )"

src_compile() {
	econf \
		--enable-curses \
		$(use_enable perl) \
		$(use_enable python) \
		$(use_with debug debug 2) \
		|| die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README TODO || die "dodoc failed"
}
