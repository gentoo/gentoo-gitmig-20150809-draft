# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-0.0.3-r1.ebuild,v 1.4 2004/06/17 22:11:43 swegener Exp $

DESCRIPTION="Portable and multi-interface IRC client."
HOMEPAGE="http://weechat.flashtux.org/"
SRC_URI="http://weechat.flashtux.org/download/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk2"

DEPEND="virtual/glibc
	sys-libs/ncurses
	gtk2? ( >=x11-libs/gtk+-2 )"
RDEPEND=""

src_compile() {
	local myconf

	use gtk2 && myconf="${myconf} --enable-gtk"
	econf ${myconf} || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall DESTDIR=${D} || die "Install failed"
	dodoc AUTHORS BUGS COPYING README
}
