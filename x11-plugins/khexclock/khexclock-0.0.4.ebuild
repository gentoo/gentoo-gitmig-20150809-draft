# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/khexclock/khexclock-0.0.4.ebuild,v 1.1 2004/07/15 01:38:08 squinky86 Exp $

inherit kde
need-kde 3

IUSE=""
DESCRIPTION="KHexClock shows the current hexadecimal time and date."
HOMEPAGE=""
SRC_URI="http://mystery.ryalth.com/~luke-jr/${P}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
