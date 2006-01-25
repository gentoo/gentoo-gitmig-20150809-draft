# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/librvp/librvp-0.4.ebuild,v 1.1 2006/01/25 12:55:31 jmglov Exp $

DESCRIPTION="An RVP (Microsoft Exchange Instant Messaging) plugin for Gaim 1.0 and upward"
HOMEPAGE="http://www.waider.ie/hacks/workshop/c/rvp/"
SRC_URI="http://www.waider.ie/hacks/workshop/c/rvp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-im/gaim-1.0.0"

src_install() {
	make install DESTDIR=${D} || die "install failure"
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README rvp_protocol.txt
}
