# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/khexclock/khexclock-0.0.4.ebuild,v 1.2 2004/07/17 09:35:32 dholm Exp $

inherit kde
need-kde 3

IUSE=""
DESCRIPTION="KHexClock shows the current hexadecimal time and date."
HOMEPAGE=""
SRC_URI="http://mystery.ryalth.com/~luke-jr/${P}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
