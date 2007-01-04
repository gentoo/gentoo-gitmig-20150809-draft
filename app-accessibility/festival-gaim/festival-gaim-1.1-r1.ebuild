# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival-gaim/festival-gaim-1.1-r1.ebuild,v 1.2 2007/01/04 13:52:09 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools

IUSE=""

DESCRIPTION="A plugin for gaim which enables text-to-speech output of conversations using festival."
HOMEPAGE="http://festival-gaim.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=app-accessibility/festival-1.4.3-r4
	 >=net-im/gaim-1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	eautoreconf

	sed -i -e 's:/usr/lib/festival/voices:/usr/share/festival/voices:g' ${S}/src/festival.c
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README ChangeLog
}
