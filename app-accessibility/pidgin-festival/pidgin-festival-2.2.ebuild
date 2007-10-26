# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/pidgin-festival/pidgin-festival-2.2.ebuild,v 1.2 2007/10/26 09:48:27 maekke Exp $

DESCRIPTION="A plugin for pidgin which enables text-to-speech output of conversations using festival."
HOMEPAGE="http://pidgin.festival.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="app-accessibility/festival
	 net-im/pidgin"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README ChangeLog
}
