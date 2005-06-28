# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-0.1.1.ebuild,v 1.3 2005/06/28 00:15:11 swegener Exp $

DESCRIPTION="Portable and multi-interface IRC client."
HOMEPAGE="http://weechat.flashtux.org/"
SRC_URI="http://weechat.flashtux.org/download/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="debug perl"

DEPEND="sys-libs/ncurses
	perl? ( dev-lang/perl )"

src_compile() {
	local myconf=""

	use perl && myconf="${myconf} --enable-perl"

	econf \
		--enable-curses \
		$(use_with debug debug 2) \
		${myconf} \
		|| die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README TODO || die "dodoc failed"
}
