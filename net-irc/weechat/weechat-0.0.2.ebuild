# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/weechat/weechat-0.0.2.ebuild,v 1.4 2004/06/24 23:10:00 agriffis Exp $

DESCRIPTION="Portable and multi-interface IRC client."
HOMEPAGE="http://weechat.flashtux.org/"
SRC_URI="http://weechat.flashtux.org/download/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND=""

src_compile() {
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc AUTHORS BUGS COPYING README
}
