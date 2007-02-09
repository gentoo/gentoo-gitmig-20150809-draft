# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/audacious-show/audacious-show-1.2.0.ebuild,v 1.4 2007/02/09 23:19:37 welp Exp $

inherit multilib

DESCRIPTION="XChat plugin to control audacious and to show whatever you're
currently playing to others"
HOMEPAGE="http://nedudu.hu/"
SRC_URI="http://nedudu.hu/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND="
	media-sound/audacious
	>=net-irc/xchat-2.4
"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/xchat/plugins/
	newins audacious-show-1.2.0.so audacious-show.so
}
