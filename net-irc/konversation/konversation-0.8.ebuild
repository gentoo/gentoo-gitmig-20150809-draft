# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/konversation/konversation-0.8.ebuild,v 1.2 2003/02/13 14:15:28 vapier Exp $

inherit kde-base
need-kde 3

DESCRIPTION="A user friendly IRC Client for KDE3.x"
HOMEPAGE="http://konversation.sourceforge.net"
SRC_URI="http://konversation.sourceforge.net/downloads/${P}.tar.gz"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86"

S=${WORKDIR}/${PN}
