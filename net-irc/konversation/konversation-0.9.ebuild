# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-0.9.ebuild,v 1.1 2003/02/07 23:30:05 hannes Exp $

inherit kde-base
need-kde 3

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.sourceforge.net"
SRC_URI="http://konversation.sourceforge.net/downloads/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86"

src_unpack() {
	kde_src_unpack
	cd ${S}
	rm configure
}

src_compile() {
	WANT_AUTOMAKE_1_6=0 WANT_AUTOCONF_2_5=0 kde_src_compile
}
