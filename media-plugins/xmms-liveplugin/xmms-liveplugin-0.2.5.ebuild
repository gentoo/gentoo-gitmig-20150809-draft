# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-liveplugin/xmms-liveplugin-0.2.5.ebuild,v 1.7 2004/09/14 07:07:03 eradicator Exp $

IUSE=""

DESCRIPTION="Plugin to support the IR port on the Sound Blaster Live Drive."
HOMEPAGE="http://liveplugin.sourceforge.net"
SRC_URI="mirror://sourceforge/liveplugin/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

DEPEND="media-sound/xmms"

src_install () {
	make DESTDIR=${D} gnulocaledir=${D}/usr/share/locale install || die
	dodoc ChangeLog INSTALL README THANKS TODO
}
