# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cxfe/cxfe-0.7.5.ebuild,v 1.2 2004/09/03 00:26:54 dholm Exp $

inherit eutils

DESCRIPTION="A command line interface for xine."
HOMEPAGE="http://www.rtwnetwork.com/cxfe/"

SRC_URI="ftp://ftp.rtwnetwork.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="lirc"

DEPEND=">=media-libs/xine-lib-1_rc1
	   virtual/x11
	   lirc? ( app-misc/lirc )
	   sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	mv cxfe ${P}

	cd ${P}

	# Fix broken Makefile
	epatch ${FILESDIR}/Makefile-fix.patch
}

src_install() {
	dobin cxfe
	dodoc COPYING README TODO lircrc-example
}
