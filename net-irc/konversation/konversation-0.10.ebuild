# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-0.10.ebuild,v 1.2 2003/03/03 16:31:15 verwilst Exp $

IUSE="nls"

inherit kde-base
need-kde 3

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.sourceforge.net"
SRC_URI="http://konversation.sourceforge.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_install() {
	
	kde_src_install

	use nls || rm -rf ${D}/usr/share/locale
}
