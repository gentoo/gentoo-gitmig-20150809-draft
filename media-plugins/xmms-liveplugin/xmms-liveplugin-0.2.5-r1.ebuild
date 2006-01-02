# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-liveplugin/xmms-liveplugin-0.2.5-r1.ebuild,v 1.1 2006/01/02 03:01:13 metalgod Exp $

IUSE=""

DESCRIPTION="Plugin to support the IR port on the Sound Blaster Live Drive."
HOMEPAGE="http://liveplugin.sourceforge.net"
SRC_URI="mirror://sourceforge/liveplugin/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="media-sound/xmms"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's/libliveir_la_LDFLAGS = @PLUGIN_LDFLAGS@/#libliveir_la_LDFLAGS = @PLUGIN_LDFLAGS@/g' src/plugin/Makefile.am || die "sed failed"
}


src_install () {
	make DESTDIR=${D} gnulocaledir=${D}/usr/share/locale install || die
	dodoc ChangeLog README THANKS TODO
}
