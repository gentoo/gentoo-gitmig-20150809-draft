# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/eflite/eflite-0.3.8.ebuild,v 1.2 2004/03/21 15:16:23 dholm Exp $

inherit eutils

DESCRIPTION="A speech server for emacspeek and other screen readers that allows them to interact with festival lite."
HOMEPAGE="http://eflite.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND=">=app-accessibility/flite-1.2"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-shared_flite.patch
	WANT_AUTOCONF=2.5 autoconf
}

src_install() {
	dobin eflite || die
	dodoc ChangeLog README INSTALL eflite_test.txt
}
