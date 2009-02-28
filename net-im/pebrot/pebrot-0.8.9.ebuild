# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pebrot/pebrot-0.8.9.ebuild,v 1.1 2009/02/28 23:52:11 patrick Exp $

inherit distutils

DESCRIPTION="curses-based MSN client"
HOMEPAGE="http://pebrot.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND=">=dev-lang/python-2.2"

DOCS="AUTHORS README PKG-INFO INSTALL ChangeLog COPYING"
