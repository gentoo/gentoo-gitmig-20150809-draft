# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/pidgin-festival/pidgin-festival-2.2-r1.ebuild,v 1.1 2009/03/07 14:57:31 patrick Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A plugin for pidgin which enables text-to-speech output of conversations using festival."
HOMEPAGE="http://pidgin.festival.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""

RDEPEND="app-accessibility/festival
	net-im/pidgin[gtk]
	>=x11-libs/gtk+-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

#pkg_setup() {
#	if ! built_with_use net-im/pidgin gtk; then
#		eerror "You need to compile net-im/pidgin with USE=gtk"
#		die "Missing gtk USE flag on net-im/pidgin"
#	fi
#}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README ChangeLog
}
