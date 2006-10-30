# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/switcher/switcher-0.3.7a.ebuild,v 1.7 2006/10/30 20:41:36 troll Exp $

inherit kde
need-kde 3.1

DESCRIPTION="A small KDE app for switching the order of letters (as in logical and visual hebrew)"
HOMEPAGE="http://www.penguin.org.il/~uvgroovy/"
SRC_URI="http://www.penguin.org.il/~uvgroovy/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-clear_from_warnings.patch
	epatch ${FILESDIR}/${P}-noarts.patch

	eautoconf
}
