# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-0.13.ebuild,v 1.2 2004/01/17 11:05:03 aliz Exp $

IUSE="nls"

inherit kde
need-kde 3

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.sourceforge.net"
SRC_URI="mirror://sourceforge/konversation/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

src_install() {
	kde_src_install
	use nls || rm -rf ${D}/usr/share/locale
}
